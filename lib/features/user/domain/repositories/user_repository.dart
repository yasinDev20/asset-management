import 'package:computer_lab_inventory_application/core/error/failure.dart';
import 'package:computer_lab_inventory_application/features/authentication/domain/entities/user_entity.dart';
import 'package:computer_lab_inventory_application/features/user/data/models/user_pagination.dart';
import 'package:computer_lab_inventory_application/features/user/domain/params/user_filter.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> getUser(String id);
  Future<Either<Failure, UserPaginationResult>> getAllUser( {
    required UserFilter? userFilter,
    required String? lastId,
    required int limit,
  });
  Future<Either<Failure, Unit>> addUser(UserEntity userData);
  Future<Either<Failure, Unit>> forgotPassword(String email);
}
