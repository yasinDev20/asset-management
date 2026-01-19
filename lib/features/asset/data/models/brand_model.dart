import 'dart:convert';

import 'package:assetmanagement/features/asset/domain/entities/brand_entity.dart';
import 'package:equatable/equatable.dart';

class BrandModel extends Equatable {
  final String id;
  final String ownerId;
  final String name;

  const BrandModel({
    required this.id,
    required this.ownerId,
    required this.name,
  });

  @override
  List<Object> get props => [id, ownerId, name];

  BrandEntity toEntity() {
    return BrandEntity(id: id, ownerId: ownerId, name: name);
  }

  factory BrandModel.fromEntity(BrandEntity entity) {
    return BrandModel(
      id: entity.id,
      ownerId: entity.ownerId,
      name: entity.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'ownerId': ownerId, 'name': name};
  }

  factory BrandModel.fromMap(Map<String, dynamic> map) {
    return BrandModel(
      id: map['id'] as String,
      ownerId: map['ownerId'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BrandModel.fromJson(String source) =>
      BrandModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
