import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/authentication/domain/entities/auth_entity.dart';
import 'package:assetmanagement/features/authentication/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class GetUserUsecase {
  final AuthRepository authRepository;

  GetUserUsecase({required this.authRepository});

  Future<Either<Failure, AuthEntity>> call({required String id}) async {
    return await authRepository.getCurrentUser(id: id);
  }
  
}
