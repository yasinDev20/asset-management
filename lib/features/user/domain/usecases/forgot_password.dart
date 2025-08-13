import 'package:computer_lab_inventory_application/core/error/failure.dart';
import 'package:computer_lab_inventory_application/features/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class ForgotPasswordUseCase {
  final UserRepository userRepository;

  ForgotPasswordUseCase({required this.userRepository});

  Future<Either<Failure, Unit>> call(String email) {
    return userRepository.forgotPassword(email);
  }
}
