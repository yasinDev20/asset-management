import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/authentication/domain/entities/user_entity.dart';
import 'package:assetmanagement/features/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class AddUserUsecase {
  final UserRepository userRepository;

  AddUserUsecase({required this.userRepository});

  Future<Either<Failure, Unit>> call(UserEntity userData) async{
    return userRepository.addUser(userData);
  }
}