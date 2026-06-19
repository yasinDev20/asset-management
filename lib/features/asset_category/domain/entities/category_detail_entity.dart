import 'package:equatable/equatable.dart';

class CategoryDetailEntity extends Equatable {
  final String id;
  final String ownerId;
  final String name;
  final String code;
  final int lastSequance;

  const CategoryDetailEntity({
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
