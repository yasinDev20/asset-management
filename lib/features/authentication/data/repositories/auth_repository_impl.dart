// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:computer_lab_inventory_application/core/utils/error_utils.dart';
import 'package:dartz/dartz.dart';
import 'package:computer_lab_inventory_application/core/error/failure.dart';
import 'package:computer_lab_inventory_application/features/authentication/data/datasources/remote_datasource.dart';
import 'package:computer_lab_inventory_application/features/authentication/domain/entities/auth_entity.dart';
import 'package:computer_lab_inventory_application/features/authentication/domain/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;
  final AuthRemoteDatasource authRemoteDatasource;

  AuthRepositoryImpl({
    required this.firebaseAuth,
    required this.googleSignIn,
    required this.authRemoteDatasource,
  });

  @override
  Future<Either<Failure, AuthEntity>> login(
    String email,
    String password,
  ) async {
    return runCatching(() async {
      final result = await authRemoteDatasource.login(
        email: email,
        password: password,
      );
      return result.toEntity();
    });
  }

  @override
  Future<Either<Failure, AuthEntity>> signInWithGoogle() async {
    return runCatching(() async {
      final result = await authRemoteDatasource.signInWithGoogle();
      return result.toEntity(); // kamu hanya kembalikan hasil
    });

    // try {
    //   AuthModel hasil = await authRemoteDatasource.signInWithGoogle();
    //   return (Right(hasil.toEntity()));
    // } on AppException catch (e) {
    //   return left(ExceptionToFailureMapper.map(e));
    // } catch (e) {
    //   return Left(ServerFailure(message: e.toString()));
    // }
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    return runCatching(() async {
      await googleSignIn.initialize();
      await googleSignIn.signOut();
      await firebaseAuth.signOut();

      return unit; // karena return type-nya Unit
    });
  }

  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() {
    return runCatching(() async {
      final authModel = await authRemoteDatasource.getCurrentUser();

      return authModel.toEntity();
    });
  }
}
