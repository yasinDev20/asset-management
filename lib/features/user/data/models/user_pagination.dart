import 'package:computer_lab_inventory_application/features/authentication/domain/entities/user_entity.dart';

class UserPaginationResult {
  final List<UserEntity> users;
  final String? lastId;

  UserPaginationResult({
    required this.users,
    required this.lastId,
  });
}