import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/authentication/domain/entities/auth_entity.dart';
import 'package:assetmanagement/features/authentication/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class EmailPasswordSignUsecase {
  final AuthRepository authRepository;

  EmailPasswordSignUsecase({required this.authRepository});

  Future<Either<Failure, AuthEntity>> call(String email, String password) async {
    return await authRepository.emailPasswordSignIn(email: email, password: password);
  }
  
}
