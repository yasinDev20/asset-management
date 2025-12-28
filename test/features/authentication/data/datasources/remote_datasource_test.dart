// ignore_for_file: subtype_of_sealed_class

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:assetmanagement/core/error/exception.dart';
import 'package:assetmanagement/features/authentication/data/datasources/remote_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

class MockUser extends Mock implements User {}

class MockFirestore extends Mock implements FirebaseFirestore {}

class MockCollection extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

class MockDocumentSnapshot extends Mock
    implements DocumentSnapshot<Map<String, dynamic>> {}

class MockFilledDocumentSnapshot extends Mock
    implements DocumentSnapshot<Map<String, dynamic>> {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockGoogleAuthProvider extends Mock implements GoogleAuthProvider {}

class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}

class MockGoogleSignInAuthentication extends Mock
    implements GoogleSignInAuthentication {}

class MockAuthCredential extends Mock implements AuthCredential {}

void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late MockUserCredential mockUserCredential;
  late MockUser mockUser;
  late MockFirestore mockFirestore;
  late MockCollection mockCollection;
  late MockDocumentReference mockDocumentReference;
  late MockDocumentSnapshot mockDocumentSnapshot;

  late AuthRemoteDatasourceImpl authRemoteDatasourceImpl;
  late MockGoogleSignIn mockGoogleSignIn;
  late MockGoogleAuthProvider mockGoogleAuthProvider;
  late MockGoogleSignInAccount mockGoogleSignInAccount;
  late MockGoogleSignInAuthentication mockGoogleSignInAuthentication;
  late MockAuthCredential mockAuthCredential;

  late String id;
  late String name;
  late String createdAt;
  late String updatedAt;
  late String email = 'test@email.com';
  late String password = '123456';
  setUp(() {
    mockGoogleSignIn = MockGoogleSignIn();
    mockFirebaseAuth = MockFirebaseAuth();
    mockUserCredential = MockUserCredential();
    mockGoogleAuthProvider = MockGoogleAuthProvider();
    mockGoogleSignInAccount = MockGoogleSignInAccount();
    mockGoogleSignInAuthentication = MockGoogleSignInAuthentication();
    mockAuthCredential = MockAuthCredential();
    registerFallbackValue(mockAuthCredential);
    mockUser = MockUser();

    mockFirestore = MockFirestore();
    mockCollection = MockCollection();
    mockDocumentReference = MockDocumentReference();
    mockDocumentSnapshot = MockDocumentSnapshot();

    authRemoteDatasourceImpl = AuthRemoteDatasourceImpl(
      isWeb: true,
      firebaseAuth: mockFirebaseAuth,
      firestore: mockFirestore,
      googleSignInPackage: mockGoogleSignIn,
      googleAuthProvider: mockGoogleAuthProvider,
    );

    id = 'id';
    name = 'yournametest';
    createdAt = DateTime(2025).toIso8601String();
    updatedAt = DateTime(2025).toIso8601String();
    email = 'test@email.com';
    password = '123456';
  });

  group('emailRegister', () {
    test('should call firebaseAuth and firestore when success', () async {
      // Mock Firebase User
      when(() => mockUser.uid).thenReturn(id);
      // when(() => mockUser.email).thenReturn(email);
      // when(() => mockUser.displayName).thenReturn(name);
      when(() => mockUserCredential.user).thenReturn(mockUser);

      // Mock FirebaseAuth login
      when(
        () => mockFirebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        ),
      ).thenAnswer((_) async => mockUserCredential);

      // Mock Firestore chain: collection → doc → get
      when(() => mockFirestore.collection('users')).thenReturn(mockCollection);

      when(() => mockCollection.doc(id)).thenReturn(mockDocumentReference);

      when(
        () => mockDocumentReference.set(any()),
      ).thenAnswer((_) async {});

      // ==== RUN =====
      await authRemoteDatasourceImpl.emailRegister(
        email: email,
        password: password,
      );

      // ==== ASSERT =====

      verify(
        () => mockFirebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        ),
      ).called(1);
      verify(() => mockFirestore.collection('users')).called(1);
    });

    test(
      'should throw AppException when userCredential.user is null',
      () async {
        when(
          () => mockFirebaseAuth.signInWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).thenAnswer((_) async => mockUserCredential);

        when(() => mockUserCredential.user).thenReturn(null);

        try {
          await authRemoteDatasourceImpl.emailPasswordSignIn(
            email: email,
            password: password,
          );
        } catch (e) {
          expect(
            e,
            AppException(
              type: ExceptionType.auth,
              code: "null-user",
              message: "User data is null",
            ),
          );
        }
      },
    );

    test(
      'should throw AppException when docSnapshot is not exists or docSnapshot data is null ',
      () async {
        // Mock FirebaseAuth
        when(
          () => mockFirebaseAuth.signInWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).thenAnswer((_) async => mockUserCredential);

        // Mock User
        when(() => mockUserCredential.user).thenReturn(mockUser);
        when(() => mockUser.uid).thenReturn(id); // pastikan ada UID valid

        // Mock Firestore
        when(
          () => mockFirestore.collection('users'),
        ).thenReturn(mockCollection);
        when(() => mockCollection.doc(id)).thenReturn(mockDocumentReference);
        when(
          () => mockDocumentReference.get(),
        ).thenAnswer((_) async => mockDocumentSnapshot);
        when(() => mockDocumentSnapshot.exists).thenReturn(false);
        when(() => mockDocumentSnapshot.data()).thenReturn(null);

        // Test AppException

        try {
          await authRemoteDatasourceImpl.emailPasswordSignIn(
            email: email,
            password: password,
          );
        } catch (e) {
          expect(
            e,
            AppException(
              type: ExceptionType.server,
              code: 'DATA_NOT_FOUND',
              message: 'user data not found',
            ),
          );
        }
      },
    );
  });
  group('emailPasswordSignIn', () {
    test('should return AuthModel when FirebaseAuth signIn success', () async {
      // Mock Firebase User
      when(() => mockUser.uid).thenReturn(id);
      // when(() => mockUser.email).thenReturn(email);
      // when(() => mockUser.displayName).thenReturn(name);
      when(() => mockUserCredential.user).thenReturn(mockUser);

      // Mock FirebaseAuth login
      when(
        () => mockFirebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        ),
      ).thenAnswer((_) async => mockUserCredential);

      // Mock Firestore chain: collection → doc → get
      when(() => mockFirestore.collection('users')).thenReturn(mockCollection);

      when(() => mockCollection.doc(id)).thenReturn(mockDocumentReference);

      when(
        () => mockDocumentReference.get(),
      ).thenAnswer((_) async => mockDocumentSnapshot);

      when(() => mockDocumentSnapshot.exists).thenReturn(true);

      when(() => mockDocumentSnapshot.data()).thenReturn({
        'id': id,
        'email': email,
        'name': name,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      });

      // ==== RUN =====
      final result = await authRemoteDatasourceImpl.emailPasswordSignIn(
        email: email,
        password: password,
      );

      // ==== ASSERT =====

      expect(result.user.id, id);
      expect(result.user.email, email);
      expect(result.user.name, name);
      expect(result.accessToken, 'firebaseauth');
      expect(result.tokenType, 'Bearer');
      expect(result.refreshToken, 'firebaseauth');
      expect(result.expiresIn, DateTime(2025));
      expect(result.refreshExpiresAt, DateTime(2025));

      verify(
        () => mockFirebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        ),
      ).called(1);
      verify(() => mockFirestore.collection('users')).called(1);
    });

    test(
      'should throw AppException when userCredential.user is null',
      () async {
        when(
          () => mockFirebaseAuth.signInWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).thenAnswer((_) async => mockUserCredential);

        when(() => mockUserCredential.user).thenReturn(null);

        try {
          await authRemoteDatasourceImpl.emailPasswordSignIn(
            email: email,
            password: password,
          );
        } catch (e) {
          expect(
            e,
            AppException(
              type: ExceptionType.auth,
              code: "null-user",
              message: "User data is null",
            ),
          );
        }
      },
    );

    test(
      'should throw AppException when docSnapshot is not exists or docSnapshot data is null ',
      () async {
        // Mock FirebaseAuth
        when(
          () => mockFirebaseAuth.signInWithEmailAndPassword(
            email: email,
            password: password,
          ),
        ).thenAnswer((_) async => mockUserCredential);

        // Mock User
        when(() => mockUserCredential.user).thenReturn(mockUser);
        when(() => mockUser.uid).thenReturn(id); // pastikan ada UID valid

        // Mock Firestore
        when(
          () => mockFirestore.collection('users'),
        ).thenReturn(mockCollection);
        when(() => mockCollection.doc(id)).thenReturn(mockDocumentReference);
        when(
          () => mockDocumentReference.get(),
        ).thenAnswer((_) async => mockDocumentSnapshot);
        when(() => mockDocumentSnapshot.exists).thenReturn(false);
        when(() => mockDocumentSnapshot.data()).thenReturn(null);

        // Test AppException

        try {
          await authRemoteDatasourceImpl.emailPasswordSignIn(
            email: email,
            password: password,
          );
        } catch (e) {
          expect(
            e,
            AppException(
              type: ExceptionType.server,
              code: 'DATA_NOT_FOUND',
              message: 'user data not found',
            ),
          );
        }
      },
    );
  });

  group('googleSignIn', () {
    test('should return AuthModel when google sign in web succes', () async {
      // Mock Firebase User
      when(() => mockUser.uid).thenReturn(id);
      // when(() => mockUser.email).thenReturn(email);
      // when(() => mockUser.displayName).thenReturn(name);
      when(() => mockUserCredential.user).thenReturn(mockUser);

      //Mock Google Sign In
      when(() => mockGoogleSignIn.initialize()).thenAnswer((_) async => {});
      when(
        () => mockGoogleAuthProvider.setCustomParameters({
          'login_hint': 'user@example.com',
        }),
      ).thenReturn(mockGoogleAuthProvider);
      when(
        () => mockFirebaseAuth.signInWithPopup(mockGoogleAuthProvider),
      ).thenAnswer((_) async => mockUserCredential);

      // Mock Firestore chain: collection → doc → get
      when(() => mockFirestore.collection('users')).thenReturn(mockCollection);

      when(() => mockCollection.doc(id)).thenReturn(mockDocumentReference);

      when(
        () => mockDocumentReference.get(),
      ).thenAnswer((_) async => mockDocumentSnapshot);

      when(() => mockDocumentSnapshot.exists).thenReturn(true);

      when(() => mockDocumentSnapshot.data()).thenReturn({
        'id': id,
        'email': email,
        'name': name,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      });

      final result = await authRemoteDatasourceImpl.googleSignIn(
        googleSignInAccaount: mockGoogleSignInAccount,
      );

      expect(result.user.id, id);
      expect(result.user.email, email);
      expect(result.user.name, name);
      expect(result.accessToken, 'firebaseauth');
      expect(result.tokenType, 'Bearer');
      expect(result.refreshToken, 'firebaseauth');
      expect(result.expiresIn, DateTime(2025));
      expect(result.refreshExpiresAt, DateTime(2025));
    });

    test('should return AuthModel when google sign in succes', () async {
      //not web
      authRemoteDatasourceImpl.isWeb = false;
      // Mock Firebase User
      when(() => mockUser.uid).thenReturn(id);
      when(() => mockUserCredential.user).thenReturn(mockUser);

      //Mock Google Sign In
      when(() => mockGoogleSignIn.initialize()).thenAnswer((_) async => {});

      when(
        () => mockGoogleSignIn.authenticate(),
      ).thenAnswer((_) async => mockGoogleSignInAccount);

      when(
        () => mockGoogleSignInAccount.authentication,
      ).thenReturn(mockGoogleSignInAuthentication);

      when(
        () => mockGoogleSignInAuthentication.idToken,
      ).thenReturn('fake_token');

      //GoogleAuthProvider.credential adalah satatic tidak bisa di stub dan mock makanya menggunakan any kemudian register di setup
      when(
        () => mockFirebaseAuth.signInWithCredential(any()),
      ).thenAnswer((_) async => mockUserCredential);

      // when(
      //   () => mockFirebaseAuth.signInWithCredential(mockAuthCredential),
      // ).thenAnswer((_) async => mockUserCredential);

      // Mock Firestore chain: collection → doc → get
      when(() => mockFirestore.collection('users')).thenReturn(mockCollection);

      when(() => mockCollection.doc(id)).thenReturn(mockDocumentReference);

      when(
        () => mockDocumentReference.get(),
      ).thenAnswer((_) async => mockDocumentSnapshot);

      when(() => mockDocumentSnapshot.exists).thenReturn(true);

      when(() => mockDocumentSnapshot.data()).thenReturn({
        'id': id,
        'email': email,
        'name': name,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      });

      final result = await authRemoteDatasourceImpl.googleSignIn(
        googleSignInAccaount: mockGoogleSignInAccount,
      );

      expect(result.user.id, id);
      expect(result.user.email, email);
      expect(result.user.name, name);
      expect(result.accessToken, 'firebaseauth');
      expect(result.tokenType, 'Bearer');
      expect(result.refreshToken, 'firebaseauth');
      expect(result.expiresIn, DateTime(2025));
      expect(result.refreshExpiresAt, DateTime(2025));
    });

    test(
      'should throw AppException when google userCredential.user is null',
      () async {
        // Mock Firebase User

        when(() => mockUserCredential.user).thenReturn(null);

        //Mock Google Sign In
        when(() => mockGoogleSignIn.initialize()).thenAnswer((_) async => {});
        when(
          () => mockGoogleAuthProvider.setCustomParameters({
            'login_hint': 'user@example.com',
          }),
        ).thenReturn(mockGoogleAuthProvider);
        when(
          () => mockFirebaseAuth.signInWithPopup(mockGoogleAuthProvider),
        ).thenAnswer((_) async => mockUserCredential);

        try {
          await authRemoteDatasourceImpl.googleSignIn(
            googleSignInAccaount: mockGoogleSignInAccount,
          );
        } catch (e) {
          expect(
            e,
            AppException(
              type: ExceptionType.auth,
              code: 'google_sign_in_failed',
              message: 'Google sign in failed: No user returned',
            ),
          );
        }
      },
    );

    test(
      'should set new user and throw AppException when docSnapshot is not exists or docSnapshot data is null ',
      () async {
        // Mock Firebase User
        when(() => mockUser.uid).thenReturn(id);
        when(() => mockUser.displayName).thenReturn(name);
        when(() => mockUserCredential.user).thenReturn(mockUser);

        //Mock Google Sign In
        when(() => mockGoogleSignIn.initialize()).thenAnswer((_) async => {});
        when(
          () => mockGoogleAuthProvider.setCustomParameters({
            'login_hint': 'user@example.com',
          }),
        ).thenReturn(mockGoogleAuthProvider);
        when(
          () => mockFirebaseAuth.signInWithPopup(mockGoogleAuthProvider),
        ).thenAnswer((_) async => mockUserCredential);

        //Mock firesore set
        when(() => mockDocumentReference.set(any())).thenAnswer((_) async {});

        // Mock Firestore chain: collection → doc → get
        when(
          () => mockFirestore.collection('users'),
        ).thenReturn(mockCollection);

        when(() => mockCollection.doc(id)).thenReturn(mockDocumentReference);

        when(
          () => mockDocumentReference.get(),
        ).thenAnswer((_) async => mockDocumentSnapshot);

        when(() => mockDocumentSnapshot.exists).thenReturn(false);

        when(() => mockDocumentSnapshot.data()).thenReturn(null);

        try {
          await authRemoteDatasourceImpl.googleSignIn(
            googleSignInAccaount: mockGoogleSignInAccount,
          );
        } catch (e) {
          expect(
            e,
            AppException(
              type: ExceptionType.server,
              code: 'DATA_NOT_FOUND',
              message: 'user data not found',
            ),
          );
        }

        verify(() => mockDocumentReference.set(any())).called(1);
        verify(() => mockDocumentReference.get(any())).called(2);
      },
    );
  });

  group('getCurrentUser', () {
    test('should throw A AuthModel when getCurrentUser succsess', () async {
      // Mock Firestore chain: collection → doc → get
      when(() => mockFirestore.collection('users')).thenReturn(mockCollection);

      when(() => mockCollection.doc(id)).thenReturn(mockDocumentReference);

      when(
        () => mockDocumentReference.get(),
      ).thenAnswer((_) async => mockDocumentSnapshot);

      when(() => mockDocumentSnapshot.exists).thenReturn(true);

      when(() => mockDocumentSnapshot.data()).thenReturn({
        'id': id,
        'email': email,
        'name': name,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      });

      final result = await authRemoteDatasourceImpl.getCurrentUser(id);

      expect(result.user.id, id);
      expect(result.user.email, email);
      expect(result.user.name, name);
      expect(result.accessToken, 'firebaseauth');
      expect(result.tokenType, 'Bearer');
      expect(result.refreshToken, 'firebaseauth');
      expect(result.expiresIn, DateTime(2025));
      expect(result.refreshExpiresAt, DateTime(2025));

      verify(() => mockFirestore.collection('users')).called(1);
    });

    test(
      'should throw AppException when docsnap empty or docsnapdata null',
      () async {
        // Mock Firestore chain: collection → doc → get
        when(
          () => mockFirestore.collection('users'),
        ).thenReturn(mockCollection);

        when(() => mockCollection.doc(id)).thenReturn(mockDocumentReference);

        when(
          () => mockDocumentReference.get(),
        ).thenAnswer((_) async => mockDocumentSnapshot);

        when(() => mockDocumentSnapshot.exists).thenReturn(false);

        when(() => mockDocumentSnapshot.data()).thenReturn(null);

        try {
          await authRemoteDatasourceImpl.getCurrentUser(id);
          fail('Expected AppException');
        } on AppException catch (e) {
          expect(
            e,
            AppException(
              type: ExceptionType.server,
              code: 'DATA_NOT_FOUND',
              message: 'user data not found',
            ),
          );
        }

        // expect(()=>authRemoteDatasourceImpl.getCurrentUser(id: id), throwsA(predicate(e)=> e.));

        verify(() => mockFirestore.collection('users')).called(1);
      },
    );
  });

  group('signOut', () {
    test('should call firebaseAuth and googleSignIn when succses', () async {
      when(() => mockFirebaseAuth.sendPasswordResetEmail(email: email)).thenAnswer((_) async => {});
      
      await authRemoteDatasourceImpl.forgotPassword(email);

      verify(() => mockFirebaseAuth.sendPasswordResetEmail(email: email)).called(1);
     
    });
  });


  group('signOut', () {
    test('should call firebaseAuth and googleSignIn when succses', () async {
      when(() => mockFirebaseAuth.signOut()).thenAnswer((_) async => {});
      when(() => mockGoogleSignIn.signOut()).thenAnswer((_) async => {});
      await authRemoteDatasourceImpl.signOut();

      verify(() => mockFirebaseAuth.signOut()).called(1);
      verify(() => mockGoogleSignIn.signOut()).called(1);
    });
  });
}
