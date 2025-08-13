import 'dart:convert';

import 'package:computer_lab_inventory_application/features/authentication/domain/entities/user_entity.dart';

class UserModel {
  final String id;
  final String email;
  final String name;
  final String identityNumber;
  final String role;
  final List<String> locations;
  final DateTime termStart;
  final DateTime termEnd;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.identityNumber,
    required this.role,
    required this.locations,
    required this.termStart,
    required this.termEnd,
    required this.createdAt,
    required this.updatedAt,
  });

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      name: name,
      identityNumber: identityNumber,
      role: role,
      locations: locations,
      termStart: termStart,
      termEnd: termEnd,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id ?? '',
      email: entity.email,
      name: entity.name,
      identityNumber: entity.identityNumber,
      role: entity.role ?? '',
      locations: entity.locations,
      termStart: entity.termStart,
      termEnd: entity.termEnd,
      createdAt: entity.createdAt ,
      updatedAt: entity.updatedAt
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'email': email,
      'name': name,
      'identityNumber': identityNumber,
      'role': role,
      'locations': locations,
      'termStart': termStart.toIso8601String(),
      'termEnd': termEnd.toIso8601String(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      identityNumber: map['identityNumber'] as String,
      role: map['role'] as String,
      locations: List<String>.from((map['locations'] as List<dynamic>)),

      //selalu gunakan date time parse karen date berstandar iso 8601
      termStart: DateTime.parse(map['termStart']),
      termEnd: DateTime.parse(map['termEnd'] as String),
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
