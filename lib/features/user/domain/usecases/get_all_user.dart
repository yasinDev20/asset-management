import 'package:computer_lab_inventory_application/core/error/failure.dart';
import 'package:computer_lab_inventory_application/features/user/data/models/user_pagination.dart';
import 'package:computer_lab_inventory_application/features/user/domain/params/user_filter.dart';
import 'package:computer_lab_inventory_application/features/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllUserUseCase {
  final UserRepository userRepository;

  GetAllUserUseCase({required this.userRepository});

  Future<Either<Failure, UserPaginationResult>> call( {
    required String? lastId,
    required int limit,
    required UserFilter? userFilter,
  }) async {
    return userRepository.getAllUser(limit: limit, lastId: lastId, userFilter:userFilter);
  }
}
