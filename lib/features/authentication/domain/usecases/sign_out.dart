// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:computer_lab_inventory_application/core/error/failure.dart';
import 'package:computer_lab_inventory_application/features/authentication/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class SignOutUsecase {
  final AuthRepository authRepository;

  SignOutUsecase({required this.authRepository});

  Future<Either<Failure, Unit>> call() async {
    return await authRepository.signOut();
  }
  
}
