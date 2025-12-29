import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/authentication/domain/entities/auth_entity.dart';
import 'package:assetmanagement/features/authentication/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';

class GetUserUsecase {
  final AuthRepository _authRepository;

  GetUserUsecase(this._authRepository);

  Future<Either<Failure, AuthEntity>> call({required String id}) async {
    return await _authRepository.getUser(id: id);
  }
  
}
