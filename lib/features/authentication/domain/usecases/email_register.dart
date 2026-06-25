import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/authentication/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class EmailRegisterUsecase {
  final AuthRepository _authRepository;
  EmailRegisterUsecase(this._authRepository);

  Future<Either<Failure, Unit>> call({
    required String name,
    required String email,
    required String password,
  }) async {
    return await _authRepository.emailRegister(
      name: name,
      email: email,
      password: password,
    );
  }
}
