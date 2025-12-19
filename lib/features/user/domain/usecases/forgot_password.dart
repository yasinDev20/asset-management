import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class ForgotPasswordUseCase {
  final UserRepository userRepository;

  ForgotPasswordUseCase({required this.userRepository});

  Future<Either<Failure, Unit>> call(String email) {
    return userRepository.forgotPassword(email);
  }
}
