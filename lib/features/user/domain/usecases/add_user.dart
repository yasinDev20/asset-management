import 'package:computer_lab_inventory_application/core/error/failure.dart';
import 'package:computer_lab_inventory_application/features/authentication/domain/entities/user_entity.dart';
import 'package:computer_lab_inventory_application/features/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class AddUserUsecase {
  final UserRepository userRepository;

  AddUserUsecase({required this.userRepository});

  Future<Either<Failure, Unit>> call(UserEntity userData) async{
    return userRepository.addUser(userData);
  }
}