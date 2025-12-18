import 'package:equatable/equatable.dart';

import 'package:computer_lab_inventory_application/features/authentication/domain/entities/user_entity.dart';

class AuthEntity extends Equatable {
  final UserEntity user;
  final String accessToken;
  final String tokenType;
  final String refreshToken;
  final DateTime expiresIn;
  final DateTime refreshExpiresAt;

  const AuthEntity({
    required this.user,
    required this.accessToken,
    required this.tokenType,
    required this.refreshToken,
    required this.expiresIn,
    required this.refreshExpiresAt,
  });

  @override
  List<Object> get props {
    return [
      user,
      accessToken,
      tokenType,
      refreshToken,
      expiresIn,
      refreshExpiresAt,
    ];
  }
}
