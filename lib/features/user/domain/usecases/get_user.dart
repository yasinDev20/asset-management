import 'package:computer_lab_inventory_application/core/error/failure.dart';
import 'package:computer_lab_inventory_application/features/authentication/domain/entities/user_entity.dart';
import 'package:computer_lab_inventory_application/features/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class GetUserUseCase {
  final UserRepository userRepository;

  GetUserUseCase({required this.userRepository});

  Future<Either<Failure, UserEntity>> call(String id) async{
    return userRepository.getUser(id);
  }
  
}