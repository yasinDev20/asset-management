import 'package:computer_lab_inventory_application/core/error/failure.dart';
import 'package:computer_lab_inventory_application/features/authentication/domain/entities/auth_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthEntity>> login(String email, String password);
  Future<Either<Failure, AuthEntity>> signInWithGoogle();
  Future<Either<Failure, Unit>> signOut();
  Future<Either<Failure, AuthEntity>> getCurrentUser();

  // // Tambahan untuk local data
  // Future<void> saveToken(String token);
  // Future<String?> getToken();
  // Future<void> clearToken();
}