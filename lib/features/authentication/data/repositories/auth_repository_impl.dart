// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:assetmanagement/core/utils/run_catching.dart';
import 'package:dartz/dartz.dart';
import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/authentication/data/datasources/remote_datasource.dart';
import 'package:assetmanagement/features/authentication/domain/entities/auth_entity.dart';
import 'package:assetmanagement/features/authentication/domain/repositories/auth_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, Unit>> emailRegister({required String email, required String password}) async {
    return runCatching(() async {
       await authRemoteDataSource.emailRegister(email: email, password: password);
       return unit;
    },);
   
  }

  @override
  Future<Either<Failure, AuthEntity>> emailPasswordSignIn(
    {required String email,
   required String password,}
  ) async {
    return runCatching(() async {
      final result = await authRemoteDataSource.emailPasswordSignIn(
        email: email,
        password: password,
      );
      return result.toEntity();
    });
  }

  @override
  Future<Either<Failure, AuthEntity>> googleSignIn({
    required GoogleSignInAccount googleSignInAccaount,
  }) async {
    return runCatching(() async {
      final result = await authRemoteDataSource.googleSignIn(googleSignInAccaount: googleSignInAccaount);
      return result.toEntity();
    });
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    return runCatching(() async {
      await authRemoteDataSource.signOut();
      return unit; // karena return type-nya Unit
    });
  }

  @override
  Future<Either<Failure, AuthEntity>> getUser({required String id}) {
    return runCatching(() async {
      final authModel = await authRemoteDataSource.getUser(id);

      return authModel.toEntity();
    });
  }
  
  @override
  Future<Either<Failure, Unit>> forgotPassword(String email) {
    return runCatching(() async{
      await authRemoteDataSource.forgotPassword(email);
      return unit;
    });
  }
  
}
