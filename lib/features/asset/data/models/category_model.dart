// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:assetmanagement/features/asset/domain/entities/category_entity.dart';
import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final String id;
  final String ownerId;
  final String name;
  final String code;
  final int lastSequance;

  const CategoryModel({
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

  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id,
      ownerId: ownerId,
      name: name,
      code: code,
      lastSequance: lastSequance,
    );
  }

  factory CategoryModel.fromEntity(CategoryEntity entity) {
    return CategoryModel(
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
      'ownerId': ownerId,
      'name': name,
      'code': code,
      'lastSequance': lastSequance,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as String,
      ownerId: map['ownerId'] as String,
      name: map['name'] as String,
      code: map['code'] as String,
      lastSequance: map['lastSequance'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
