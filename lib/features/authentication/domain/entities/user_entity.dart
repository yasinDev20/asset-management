// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? id;
  final String email;
  final String name;
  final String identityNumber;
  final String? role;
  final List<String> locations;
  final DateTime termStart;
  final DateTime termEnd;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const UserEntity({
    this.id,
    required this.email,
    required this.name,
    required this.identityNumber,
     this.role,
    required this.locations,
    required this.termStart,
    required this.termEnd,
    this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props {
    return [
      id,
      email,
      name,
      identityNumber,
      role,
      locations,
      termStart,
      termEnd,
      createdAt,
      updatedAt,
    ];
  }

  UserEntity copyWith({
    String? id,
    String? email,
    String? name,
    String? identityNumber,
    String? role,
    List<String>? locations,
    DateTime? termStart,
    DateTime? termEnd,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      identityNumber: identityNumber ?? this.identityNumber,
      role: role ?? this.role,
      locations: locations ?? this.locations,
      termStart: termStart ?? this.termStart,
      termEnd: termEnd ?? this.termEnd,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
