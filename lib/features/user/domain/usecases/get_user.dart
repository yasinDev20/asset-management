import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/authentication/domain/entities/user_entity.dart';
import 'package:assetmanagement/features/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class GetUserUseCase {
  final UserRepository userRepository;

  GetUserUseCase({required this.userRepository});

  Future<Either<Failure, UserEntity>> call(String id) async{
    return userRepository.getUser(id);
  }
  
}