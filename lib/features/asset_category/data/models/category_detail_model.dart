// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:assetmanagement/features/asset_category/domain/entities/category_detail_entity.dart';
import 'package:equatable/equatable.dart';

class CategoryDetailModel extends Equatable {
  final String id;
  final String ownerId;
  final String name;
  final String code;
  final int lastSequance;

  const CategoryDetailModel({
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

  CategoryDetailEntity toEntity() {
    return CategoryDetailEntity(
      id: id,
      ownerId: ownerId,
      name: name,
      code: code,
      lastSequance: lastSequance,
    );
  }

  factory CategoryDetailModel.fromEntity(CategoryDetailEntity entity) {
    return CategoryDetailModel(
      id: entity.id,
      ownerId: entity.ownerId,
      name: entity.name,
      code: entity.code,
      lastSequance: entity.lastSequance,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'owner_id': ownerId,
      'name': name,
      'code': code,
      'last_sequence': lastSequance,
    };
  }

  factory CategoryDetailModel.fromMap(Map<String, dynamic> map) {
    return CategoryDetailModel(
      id: map['id'] as String,
      ownerId: map['owner_id'] as String,
      name: map['name'] as String,
      code: map['code'] as String,
      lastSequance: map['last_sequence'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryDetailModel.fromJson(String source) =>
      CategoryDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
