import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:assetmanagement/core/error/exception.dart';
import 'package:assetmanagement/features/authentication/data/models/auth_model.dart';
import 'package:assetmanagement/features/authentication/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthRemoteDatasource {
  Future<void> emailRegister({required String email, required String password});
  Future<AuthModel> emailPasswordSignIn({
    required String email,
    required String password,
  });
  Future<AuthModel> googleSignIn({
    required GoogleSignInAccount googleSignInAccaount,
  });
  Future<AuthModel> getCurrentUser({required String id});
  Future<void> signOut();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  bool isWeb;
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;
  final GoogleSignIn googleSignInPackage;
  final GoogleAuthProvider googleAuthProvider;

  AuthRemoteDatasourceImpl({
    required this.isWeb,
    required this.firebaseAuth,
    required this.firestore,
    required this.googleSignInPackage,
    required this.googleAuthProvider,
  });

  @override
  Future<void> emailRegister({
    required String email,
    required String password,
  }) async {
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = userCredential.user!.uid;
    final usersRef = firestore.collection('users').doc(uid);

    final user = userCredential.user!;
    await usersRef.set({
      'id': user.uid,
      'name': user.displayName ?? 'name',
      'email': user.email,
      'createdAt': DateTime.now().toIso8601String(),
    });
  }

  @override
  Future<AuthModel> emailPasswordSignIn({
    required String email,
    required String password,
  }) async {
    final userCredential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final user = userCredential.user;

    if (user == null) {
      throw AppException(
        type: ExceptionType.auth,
        message: "User data is null",
        code: "null-user",
      );
    }

    final docSnap = await firestore.collection('users').doc(user.uid).get();

    if (!docSnap.exists || docSnap.data() == null) {
      throw AppException(
        type: ExceptionType.server,
        code: 'DATA_NOT_FOUND',
        message: 'user data not found',
      );
    }

    return AuthModel(
      user: UserModel.fromMap(docSnap.data()!),
      accessToken: 'firebaseauth',
      tokenType: 'Bearer',
      refreshToken: 'firebaseauth',
      expiresIn: DateTime(2025),
      refreshExpiresAt: DateTime(2025),
    );
  }

  @override
  Future<AuthModel> googleSignIn({
    required GoogleSignInAccount googleSignInAccaount,
  }) async {
    late UserCredential userCredential;
    //tambahkan clientId dan serverClientId untuk ios dan web jika tidak menggunakan firebase
    // String clientId ='';

    // String serverClientId =

    // const List<String> scopes = <String>[
    //   // 'https://www.googleapis.com/auth/contacts.readonly',
    // ];

    if (isWeb) {
      googleAuthProvider.setCustomParameters({
        'login_hint': 'user@example.com',
      });

      userCredential = await firebaseAuth.signInWithPopup(googleAuthProvider);
    } else {
      //ANDROID / IOS / DESKTOP

      final idToken = googleSignInAccaount.authentication.idToken;

      final credential = GoogleAuthProvider.credential(idToken: idToken);

      userCredential = await firebaseAuth.signInWithCredential(credential);
    }

    if (userCredential.user == null) {
      // If userCredential.user is null, throw an exception to avoid returning null.
      throw AppException(
        type: ExceptionType.auth,
        code: 'google_sign_in_failed',
        message: 'Google sign in failed: No user returned',
      );
    }

    final uid = userCredential.user!.uid;
    final usersRef = firestore.collection('users').doc(uid);

    // Ambil data user dari Firestore
    var doc = await usersRef.get();

    // Jika belum ada, buat user baru
    if (!doc.exists || doc.data() == null) {
      final user = userCredential.user!;
      await usersRef.set({
        'id': user.uid,
        'name': user.displayName,
        'email': user.email,
        'createdAt': DateTime.now().toIso8601String(),
      });

      // Ambil ulang setelah create
      doc = await usersRef.get();
    }

    if (doc.data() == null) {
      throw AppException(
        type: ExceptionType.server,
        code: 'DATA_NOT_FOUND',
        message: 'user data not found',
      );
    }
    // Pasti sudah ada data user di sini
    final userModel = UserModel.fromMap(doc.data()!);

    return AuthModel(
      user: userModel,
      accessToken: 'firebaseauth',
      tokenType: 'Bearer',
      refreshToken: 'firebaseauth',
      expiresIn: DateTime(2025),
      refreshExpiresAt: DateTime(2025),
    );
  }

  @override
  Future<AuthModel> getCurrentUser({required String id}) async {
    final docSnapshot = await firestore.collection('users').doc(id).get();

    if (!docSnapshot.exists || docSnapshot.data() == null) {
      throw AppException(
        type: ExceptionType.server,
        code: 'DATA_NOT_FOUND',
        message: 'user data not found',
      );
    }

    final userModel = UserModel.fromMap(docSnapshot.data()!);

    return AuthModel(
      user: userModel,
      accessToken: 'firebaseauth',
      tokenType: 'Bearer',
      refreshToken: 'firebaseauth',
      expiresIn: DateTime(2025),
      refreshExpiresAt: DateTime(2025),
    );
  }

  @override
  Future<void> signOut() async {
    await googleSignInPackage.signOut();
    await firebaseAuth.signOut();
  }
}
