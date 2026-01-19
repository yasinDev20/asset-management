// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String id;
  final String ownerId;
  final String name;
  final String code;
  final int lastSequance;

  const CategoryEntity({
    required this.id,
    required this.ownerId,
    required this.name,
    required this.code,
    required this.lastSequance,
  });

  @override
  List<Object> get props {
    return [id, ownerId, name, code, lastSequance];
  }
}
