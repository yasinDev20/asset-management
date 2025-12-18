// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String name;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const UserEntity({
    required this.id,
    required this.email,
    required this.name,
    required this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props {
    return [id, email, name, createdAt, updatedAt];
  }

  

  UserEntity copyWith({
    String? id,
    String? email,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
