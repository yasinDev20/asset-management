import 'dart:async';
import 'dart:io';
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
  Future<void> emailPasswordSignIn({
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
  Future<void> emailPasswordSignIn({
    required String email,
    required String password,
  }) async {
    await _supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
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

    return AuthModel(user: userModel);
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
