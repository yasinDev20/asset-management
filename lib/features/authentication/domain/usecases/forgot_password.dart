import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/authentication/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class ForgotPasswordUsecase {
  final AuthRepository _authRepository;

  ForgotPasswordUsecase(this._authRepository);

  Future<Either<Failure, Unit>> call(String email) async {
    return await _authRepository.forgotPassword(email);
  }
}
