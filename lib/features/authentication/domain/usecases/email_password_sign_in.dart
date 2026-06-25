import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/authentication/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class EmailPasswordSignUsecase {
  final AuthRepository _authRepository;

  EmailPasswordSignUsecase(this._authRepository);

  Future<Either<Failure, Unit>> call({
    required String email,
    required String password,
  }) async {
    return await _authRepository.emailPasswordSignIn(
      email: email,
      password: password,
    );
  }
}
