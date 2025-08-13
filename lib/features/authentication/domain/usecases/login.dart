import 'package:computer_lab_inventory_application/core/error/failure.dart';
import 'package:computer_lab_inventory_application/features/authentication/domain/entities/auth_entity.dart';
import 'package:computer_lab_inventory_application/features/authentication/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class EmailPasswordSignUsecase {
  final AuthRepository authRepository;

  EmailPasswordSignUsecase({required this.authRepository});

  Future<Either<Failure, AuthEntity>> call(String email, String password) async {
    return await authRepository.login(email, password);
  }
  
}
