import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:computer_lab_inventory_application/core/error/exception.dart';
import 'package:computer_lab_inventory_application/features/authentication/data/models/auth_model.dart';
import 'package:computer_lab_inventory_application/features/authentication/data/models/user_model.dart';
import 'package:computer_lab_inventory_application/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthRemoteDatasource {
  Future<AuthModel> login({required String email, required String password});
  Future<void> googleInitialize();
  void googleSignInEventListener(AuthBloc authbloc);
  void disposeGoogleSignInEventListener();
  Future<AuthModel> signInWithGoogle();
  Future<AuthModel> getCurrentUser();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final GoogleSignIn googleSignIn;

  AuthRemoteDatasourceImpl({
    required this.firebaseAuth,
    required this.firestore,
    required this.googleSignIn,
  });

  StreamSubscription? _subscription;

  @override
  Future<AuthModel> login({
    required String email,
    required String password,
  }) async {
    final authenticated = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (authenticated.user != null) {
      final userQuery = await firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (userQuery.docs.isEmpty) {
        throw AppException(
          type: ExceptionType.auth,
          message: 'User not found after authentication.',
        );
      }

      return AuthModel(
        user: UserModel.fromMap(userQuery.docs.first.data()),
        accessToken: 'firebaseauth',
        tokenType: 'Bearer',
        refreshToken: 'firebaseauth',
        expiresIn: DateTime.now().add(Duration(hours: 1)),
        refreshExpiresAt: DateTime.now().add(Duration(days: 30)),
      );
    }

    throw AppException(
      type: ExceptionType.auth,
      message: 'Authentication failed',
    );
  }

  @override
  Future<void> googleInitialize() async {
    await googleSignIn.initialize();
  }

  @override
  void disposeGoogleSignInEventListener() {
    _subscription?.cancel();
    _subscription = null;
    // 🔒 bersihkan instance
  }

  @override
  void googleSignInEventListener(AuthBloc authBloc) {
    //hapus StreamSubscription sebelumnya jika ada
    if (_subscription != null) {
      disposeGoogleSignInEventListener();
    }

    // debugPrint('[GoogleSignIn] 👂 Listener re-attached');

    _subscription = googleSignIn.authenticationEvents.listen((event) {
      // debugPrint('[GoogleSignIn] 📥 Event received: $event');

      //hati hati tidak menjamin mengubah event ke GoogleSignInAuthenticationEventSignOut setelah signout
      final user = switch (event) {
        GoogleSignInAuthenticationEventSignIn(:final user) => user,
        GoogleSignInAuthenticationEventSignOut() => null,
      };

      if (user != null) {
        // debugPrint('[GoogleSignIn] 🔁 Dispatching BLoC event');
        authBloc.add(GoogleSignInEvent());
      }
      //karena tidak pasti eventnya berubah maka _subscription di cancel saja setelah dan sebelum di panggil
      //agar tidak membuat StreamSubscription ganda
      //hapus StreamSubscription jika google signout
      disposeGoogleSignInEventListener();
    });
  }

  @override
  Future<AuthModel> signInWithGoogle() async {
    late UserCredential authenticated;
    //tambahkan clientId dan serverClientId untuk ios dan web jika tidak menggunakan firebase
    // String clientId ='';

    // String serverClientId =

    // const List<String> scopes = <String>[
    //   // 'https://www.googleapis.com/auth/contacts.readonly',
    // ];

    if (kIsWeb) {
      // 🔹 WEB
      GoogleAuthProvider googleProvider = GoogleAuthProvider();
      googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

      authenticated = await firebaseAuth.signInWithPopup(googleProvider);
    } else {
      // 🔹 ANDROID / IOS / DESKTOP
      await googleInitialize();

      final GoogleSignInAccount googleUser = await googleSignIn.authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      authenticated = await firebaseAuth.signInWithCredential(credential);
    }

    if (authenticated.user != null) {
      final doc = await firestore
          .collection('users')
          .doc(authenticated.user!.uid)
          .get();

      if (!doc.exists) {
        throw AppException(
          type: ExceptionType.auth,
          message: 'User not found after authentication.',
        );
      }

      return AuthModel(
        user: UserModel.fromMap(doc.data()!),
        accessToken: 'firebaseauth',
        tokenType: 'Bearer',
        refreshToken: 'firebaseauth',
        expiresIn: DateTime.now().add(Duration(hours: 1)),
        refreshExpiresAt: DateTime.now().add(Duration(days: 30)),
      );
    }

    throw AppException(
      type: ExceptionType.auth,
      message: 'Authentication failed',
    );

    // return AuthModel(
    //   user: UserModel(
    //     id: 'id',
    //     email: 'email',
    //     name: '',
    //     identityNumber: 'identityNumber',
    //     role: 'role',
    //     locations: ['room'],
    //     termStart: DateTime.now(),
    //     termEnd: DateTime.now(),
    //     createdAt: DateTime.now(),
    //     updatedAt: DateTime.now(),
    //   ),
    //   accessToken: 'accessToken',
    //   tokenType: 'tokenType',
    //   refreshToken: 'refreshToken',
    //   expiresIn: DateTime.now(),
    //   refreshExpiresAt: DateTime.now(),
    // );
  }

  @override
  Future<AuthModel> getCurrentUser() async {
    final currentUser = firebaseAuth.currentUser;

    if (currentUser == null) {
      throw AppException(
        type: ExceptionType.auth,
        message: 'No logged-in user',
      );
    }

    final docSnapshot = await firestore
        .collection('users')
        .doc(currentUser.uid)
        .get();
    if (!docSnapshot.exists || docSnapshot.data() == null) {
      throw AppException(
        type: ExceptionType.server,
        message: 'User data not found in Firestore',
      );
    }
    final data = docSnapshot.data();
    final userModel = UserModel.fromMap(data!);

    return AuthModel(
      user: userModel,
      accessToken: 'accessToken',
      tokenType: 'tokenType',
      refreshToken: 'refreshToken',
      expiresIn: DateTime(0),
      refreshExpiresAt: DateTime(0),
    );
  }
}






// return AuthModel(
      //   user: UserModel(
      //     id: 'id',
      //     email: 'email',
      //     name: '',
      //     identityNumber: 'identityNumber',
      //     role: 'role',
      //     room: 'room',
      //     startedDate: DateTime.now(),
      //     finishDate: DateTime.now(),
      //     createdAt: DateTime.now(),
      //     updatedAt: DateTime.now(),
      //   ),
      //   accessToken: 'accessToken',
      //   tokenType: 'tokenType',
      //   refreshToken: 'refreshToken',
      //   expiresIn: DateTime.now(),
      //   refreshExpiresAt: DateTime.now(),
      // );