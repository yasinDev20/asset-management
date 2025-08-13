import 'package:computer_lab_inventory_application/core/error/failure.dart';
import 'package:computer_lab_inventory_application/features/authentication/domain/entities/auth_entity.dart';
import 'package:computer_lab_inventory_application/features/authentication/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class GoogleSignInUsecase {
  final AuthRepository authRepository;
  GoogleSignInUsecase({required this.authRepository});
  Future<Either<Failure, AuthEntity>> call() async {
    return await authRepository.signInWithGoogle();
  }
}