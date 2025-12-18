// ignore_for_file: public_member_api_docs, sort_constructors_first
//model digunakan untuk mengambil data dan diubah menjadi entity
//model tidak boleh digunakan untuk presentation
//fields model boleh diubah sesuai api atau database
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:computer_lab_inventory_application/features/authentication/data/models/user_model.dart';
import 'package:computer_lab_inventory_application/features/authentication/domain/entities/auth_entity.dart';

class AuthModel extends Equatable {
  final UserModel user;
  final String accessToken;
  final String tokenType;
  final String refreshToken;
  final DateTime expiresIn;
  final DateTime refreshExpiresAt;

  const AuthModel({
    required this.user,
    required this.accessToken,
    required this.tokenType,
    required this.refreshToken,
    required this.expiresIn,
    required this.refreshExpiresAt,
  });

  AuthEntity toEntity() {
    return AuthEntity(
      user: user.toEntity(),
      accessToken: accessToken,
      tokenType: tokenType,
      refreshToken: refreshToken,
      expiresIn: expiresIn,
      refreshExpiresAt: refreshExpiresAt,
    );
  }

  factory AuthModel.fromEntity(AuthEntity entity) {
    return AuthModel(
      user: UserModel.fromEntity(entity.user),
      accessToken: entity.accessToken,
      tokenType: entity.tokenType,
      refreshToken: entity.refreshToken,
      expiresIn: entity.expiresIn,
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

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      user: UserModel.fromMap(map['user'] as Map<String, dynamic>),
      accessToken: map['accessToken'] as String,
      tokenType: map['tokenType'] as String,
      refreshToken: map['refreshToken'] as String,
      expiresIn: DateTime.parse(map['expiresIn']),
      refreshExpiresAt: DateTime.parse(map['refreshExpiresAt']),
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthModel.fromJson(String source) =>
      AuthModel.fromMap(json.decode(source) as Map<String, dynamic>);

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
