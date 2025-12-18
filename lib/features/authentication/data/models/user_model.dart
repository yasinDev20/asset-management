import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:computer_lab_inventory_application/features/authentication/domain/entities/user_entity.dart';

class UserModel extends Equatable {
  final String id;
  final String email;
  final String name;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      name: name,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      email: entity.email,
      name: entity.name,
      createdAt: entity.createdAt ,
      updatedAt: entity.updatedAt
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'name': name,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      //selalu gunakan date time parse karen date berstandar iso 8601
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object> get props {
    return [
      id,
      email,
      name,
      createdAt,
      ?updatedAt,
    ];
  }
}
