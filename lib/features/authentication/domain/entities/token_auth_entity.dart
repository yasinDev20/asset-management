import 'package:assetmanagement/features/authentication/domain/entities/auth_entity.dart';

class TokenAuthEntity extends AuthEntity {
  final String accessToken;
  final String tokenType;
  final String refreshToken;
  final DateTime expiresAt;
  final DateTime refreshExpiresAt;

  const TokenAuthEntity({
    required super.user,
    required this.accessToken,
    required this.tokenType,
    required this.refreshToken,
    required this.expiresAt,
    required this.refreshExpiresAt,
  });

  @override
  List<Object?> get props {
    return [accessToken, tokenType, refreshToken, expiresAt, refreshExpiresAt];
  }
}
