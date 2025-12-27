import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/authentication/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class EmailRegisterUsecase {
  final AuthRepository authRepository;
  EmailRegisterUsecase(this.authRepository);

  Future<Either<Failure, Unit>> call({required String email, required String password}) async{
   return await authRepository.emailRegister(email: email, password: password);
  }
}