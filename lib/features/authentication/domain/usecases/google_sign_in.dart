import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/authentication/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class GoogleSignInUsecase {
  final AuthRepository _authRepository;
  GoogleSignInUsecase(this._authRepository);

  Future<Either<Failure, Unit>> call() async {
    return await _authRepository.googleSignIn();
  }
}
