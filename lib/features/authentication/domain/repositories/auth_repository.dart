import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/authentication/domain/entities/auth_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthRepository {
  Future<Either<Failure, Unit>> emailRegister( {required String email, required String password});
  Future<Either<Failure, AuthEntity>> emailPasswordSignIn({required String email,required String password});
  Future<Either<Failure, AuthEntity>> googleSignIn({required GoogleSignInAccount googleSignInAccaount});
  Future<Either<Failure, Unit>> signOut();
  Future<Either<Failure, AuthEntity>> getCurrentUser({required String id});

  // // Tambahan untuk local data
  // Future<void> saveToken(String token);
  // Future<String?> getToken();
  // Future<void> clearToken();
}