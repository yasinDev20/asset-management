import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/user/data/models/user_pagination.dart';
import 'package:assetmanagement/features/user/domain/params/user_filter.dart';
import 'package:assetmanagement/features/user/domain/repositories/user_repository.dart';
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
