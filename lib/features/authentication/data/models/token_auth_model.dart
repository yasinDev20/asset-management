//model digunakan untuk mengambil data dan diubah menjadi entity
//model tidak boleh digunakan untuk presentation
//fields model boleh diubah sesuai api atau database
import 'dart:convert';

import 'package:assetmanagement/features/authentication/domain/entities/token_auth_entity.dart';
import 'package:equatable/equatable.dart';

import 'package:assetmanagement/features/authentication/data/models/user_model.dart';

class TokenAuthModel extends Equatable {
  final UserModel user;
  final String accessToken;
  final String tokenType;
  final String refreshToken;
  final DateTime expiresIn;
  final DateTime refreshExpiresAt;

  const TokenAuthModel({
    required this.user,
    required this.accessToken,
    required this.tokenType,
    required this.refreshToken,
    required this.expiresIn,
    required this.refreshExpiresAt,
  });

  TokenAuthEntity toEntity() {
    return TokenAuthEntity(
      user: user.toEntity(),
      accessToken: accessToken,
      tokenType: tokenType,
      refreshToken: refreshToken,
      expiresAt: expiresIn,
      refreshExpiresAt: refreshExpiresAt,
    );
  }

  factory TokenAuthModel.fromEntity(TokenAuthEntity entity) {
    return TokenAuthModel(
      user: UserModel.fromEntity(entity.user),
      accessToken: entity.accessToken,
      tokenType: entity.tokenType,
      refreshToken: entity.refreshToken,
      expiresIn: entity.expiresAt,
      refreshExpiresAt: entity.refreshExpiresAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user.toMap(),
      'accessToken': accessToken,
      'tokenType': tokenType,
      'refreshToken': refreshToken,
      'expiresIn': expiresIn.toIso8601String(),
      'refreshExpiresAt': refreshExpiresAt.toIso8601String(),
    };
  }

  factory TokenAuthModel.fromMap(Map<String, dynamic> map) {
    return TokenAuthModel(
      user: UserModel.fromMap(map['user'] as Map<String, dynamic>),
      accessToken: map['accessToken'] as String,
      tokenType: map['tokenType'] as String,
      refreshToken: map['refreshToken'] as String,
      expiresIn: DateTime.parse(map['expiresIn']),
      refreshExpiresAt: DateTime.parse(map['refreshExpiresAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TokenAuthModel.fromJson(String source) =>
      TokenAuthModel.fromMap(json.decode(source) as Map<String, dynamic>);

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
