import 'package:equatable/equatable.dart';
import 'package:assetmanagement/features/authentication/domain/entities/user_entity.dart';

class AuthEntity extends Equatable {
  final UserEntity user;

  const AuthEntity({required this.user});

  @override
  List<Object?> get props {
    return [user];
  }
}
