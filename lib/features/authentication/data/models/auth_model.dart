// ignore_for_file: public_member_api_docs, sort_constructors_first
//model digunakan untuk mengambil data dan diubah menjadi entity
//model tidak boleh digunakan untuk presentation
//fields model boleh diubah sesuai api atau database
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:assetmanagement/features/authentication/data/models/user_model.dart';
import 'package:assetmanagement/features/authentication/domain/entities/auth_entity.dart';

class AuthModel extends Equatable {
  final UserModel user;

  const AuthModel({required this.user});

  AuthEntity toEntity() {
    return AuthEntity(user: user.toEntity());
  }

  factory AuthModel.fromEntity(AuthEntity entity) {
    return AuthModel(user: UserModel.fromEntity(entity.user));
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'user': user.toMap()};
  }

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      user: UserModel.fromMap(map['user'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthModel.fromJson(String source) =>
      AuthModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object> get props {
    return [user];
  }
}
