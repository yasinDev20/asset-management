// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/authentication/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class SignOutUsecase {
  final AuthRepository _authRepository;

  SignOutUsecase(this._authRepository);

  Future<Either<Failure, Unit>> call() async {
    return await _authRepository.signOut();
  }
  
}
