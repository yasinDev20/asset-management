import 'package:computer_lab_inventory_application/core/error/failure.dart';
import 'package:computer_lab_inventory_application/features/authentication/domain/entities/auth_entity.dart';
import 'package:computer_lab_inventory_application/features/authentication/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInUsecase {
  final AuthRepository authRepository;
  GoogleSignInUsecase({required this.authRepository});

  Future<Either<Failure, AuthEntity>> call({
    required GoogleSignInAccount googleSignInAccaount,
  }) async {
    return await authRepository.googleSignIn(googleSignInAccaount: googleSignInAccaount);
  }
}
