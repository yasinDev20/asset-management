import 'dart:async';
import 'dart:io' ;
import 'package:assetmanagement/core/error/exception.dart';
import 'package:assetmanagement/features/authentication/data/models/auth_model.dart';
import 'package:assetmanagement/features/authentication/data/models/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRemoteDatasource {
  Future<void> emailRegister({
    required String name,
    required String email,
    required String password,
  });
  Future<AuthModel> emailPasswordSignIn({
    required String email,
    required String password,
  });
  Future<void> googleSignIn();
  Stream<GoogleSignInAccount?> googleSignInStateChanges();
  Future<AuthModel> getUser(String id);
  Stream<String?> authStateChanges();
  Future<void> forgotPassword(String email);
  Future<void> signOut();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final GoogleSignIn _googleSignInPackage;
  final SupabaseClient _supabaseClient;

  AuthRemoteDatasourceImpl({
    required GoogleSignIn googleSignInPackage,
    required SupabaseClient supabaseClient,
  }) : _googleSignInPackage = googleSignInPackage,
       _supabaseClient = supabaseClient;

  @override
  Future<void> emailRegister({
    required String name,
    required String email,
    required String password,
  }) async {
    await _supabaseClient.auth.signUp(
      email: email,
      password: password,
      data: {'name': name},
    );
  }

  @override
  Future<AuthModel> emailPasswordSignIn({
    required String email,
    required String password,
  }) async {
    final userCredential = await _supabaseClient.auth.signInWithPassword(
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

    final response = await _supabaseClient
        .from('users')
        .select('*')
        .eq('id', user.id)
        .single();

    return AuthModel(
      user: UserModel.fromMap(response),
      accessToken: 'firebaseauth',
      tokenType: 'Bearer',
      refreshToken: 'firebaseauth',
      expiresIn: DateTime(2025),
      refreshExpiresAt: DateTime(2025),
    );
  }

  @override
  Future<void> googleSignIn() async {
    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      final googleSignInAccaount = await _googleSignInPackage.authenticate();
      final idToken = googleSignInAccaount.authentication.idToken;
      if (idToken == null) {
        throw AppException(
          type: ExceptionType.auth,
          code: 'google_sign_in_failed',
          message: 'Google sign in failed: No user returned',
        );
      }

      await _supabaseClient.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
      );
    } else {
      await _supabaseClient.auth.signInWithOAuth(OAuthProvider.google);
    }
  }

  @override
  Future<AuthModel> getUser(String id) async {
    final currentSession = _supabaseClient.auth.currentSession;
    final response = await _supabaseClient
        .from('users')
        .select('*')
        .eq('id', id)
        .single();

    final userModel = UserModel.fromMap(response);

    return AuthModel(
      user: userModel,
      accessToken: currentSession?.accessToken ?? '',
      tokenType: currentSession?.tokenType ?? '',
      refreshToken: currentSession?.refreshToken ?? '',
      expiresIn: currentSession?.expiresIn != null
          ? DateTime.fromMillisecondsSinceEpoch(currentSession!.expiresIn!)
          : DateTime(2000),
      refreshExpiresAt: currentSession?.expiresIn != null
          ? DateTime.fromMillisecondsSinceEpoch(currentSession!.expiresAt!)
          : DateTime(2000),
    );
  }

  @override
  Future<void> forgotPassword(String email) async {
    await _supabaseClient.auth.resetPasswordForEmail(email);
  }

  @override
  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
    await _googleSignInPackage.signOut();
  }

  @override
  Stream<String?> authStateChanges() {
    return _supabaseClient.auth.onAuthStateChange.map((event) {
      final userId = event.session?.user.id;
      return userId;
    });
  }

  @override
  Stream<GoogleSignInAccount?> googleSignInStateChanges() {
    return _googleSignInPackage.authenticationEvents.map((event) {
      final user = switch (event) {
        GoogleSignInAuthenticationEventSignIn(:final user) => user,
        GoogleSignInAuthenticationEventSignOut() => null,
      };
      return user;
    });
  }
}
