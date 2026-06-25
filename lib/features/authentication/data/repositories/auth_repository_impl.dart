// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';

import 'package:assetmanagement/core/utils/run_catching.dart';
import 'package:dartz/dartz.dart';
import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/authentication/data/datasources/remote_datasource.dart';
import 'package:assetmanagement/features/authentication/domain/entities/auth_entity.dart';
import 'package:assetmanagement/features/authentication/domain/repositories/auth_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource _authRemoteDataSource;

  AuthRepositoryImpl({required AuthRemoteDatasource authRemoteDataSource})
    : _authRemoteDataSource = authRemoteDataSource;

  @override
  Future<Either<Failure, Unit>> emailRegister({
    required String name,
    required String email,
    required String password,
  }) async {
    return runCatching(() async {
      await _authRemoteDataSource.emailRegister(
        name: name,
        email: email,
        password: password,
      );
      return unit;
    });
  }

  @override
  Future<Either<Failure, AuthEntity>> emailPasswordSignIn({
    required String email,
    required String password,
  }) async {
    return runCatching(() async {
      final result = await _authRemoteDataSource.emailPasswordSignIn(
        email: email,
        password: password,
      );
      return result.toEntity();
    });
  }

  @override
  Future<Either<Failure, Unit>> googleSignIn() async {
    return runCatching(() async {
      await _authRemoteDataSource.googleSignIn(
      );
      return unit;
    });
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    return runCatching(() async {
      await _authRemoteDataSource.signOut();
      return unit; // karena return type-nya Unit
    });
  }

  @override
  Future<Either<Failure, AuthEntity>> getUser({required String id}) {
    return runCatching(() async {
      final authModel = await _authRemoteDataSource.getUser(id);

      return authModel.toEntity();
    });
  }

  @override
  Future<Either<Failure, Unit>> forgotPassword(String email) {
    return runCatching(() async {
      await _authRemoteDataSource.forgotPassword(email);
      return unit;
    });
  }

  @override
  Stream<String?> authStateChanges() {
    return _authRemoteDataSource.authStateChanges();
  }

  @override
  Stream<GoogleSignInAccount?> googleSignInStateChanges() {
    return _authRemoteDataSource.googleSignInStateChanges();
  }
}
