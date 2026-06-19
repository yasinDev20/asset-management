import 'dart:convert';

import 'package:assetmanagement/features/asset_brand/domain/entities/brand_detail_entity.dart';
import 'package:equatable/equatable.dart';

class BrandDetailModel extends Equatable {
  final String id;
  final String ownerId;
  final String name;

  const BrandDetailModel({
    required this.id,
    required this.ownerId,
    required this.name,
  });

  @override
  List<Object> get props => [id, ownerId, name];

  BrandDetailEntity toEntity() {
    return BrandDetailEntity(id: id, ownerId: ownerId, name: name);
  }

  factory BrandDetailModel.fromEntity(BrandDetailEntity entity) {
    return BrandDetailModel(
      id: entity.id,
      ownerId: entity.ownerId,
      name: entity.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'owner_id': ownerId, 'name': name};
  }

  factory BrandDetailModel.fromMap(Map<String, dynamic> map) {
    return BrandDetailModel(
      id: map['id'] as String,
      ownerId: map['owner_id'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BrandDetailModel.fromJson(String source) =>
      BrandDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
