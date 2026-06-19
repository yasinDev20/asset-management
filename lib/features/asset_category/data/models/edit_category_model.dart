// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:assetmanagement/features/asset_category/domain/entities/edit_category_entity.dart';
import 'package:equatable/equatable.dart';

class EditCategoryModel extends Equatable {
  final String id;
  final String? name;
  final String? code;

  const EditCategoryModel({
    required this.id,
    required this.name,
    required this.code,
  });

  @override
  List<Object> get props {
    return [id, ?name, ?code];
  }

  factory EditCategoryModel.fromEntity(EditCategoryEntity entity) {
    return EditCategoryModel(
      id: entity.id,
      name: entity.name,
      code: entity.code,
    );
  }

  EditCategoryEntity toEntity() {
    return EditCategoryEntity(id: id, name: name, code: code);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'name': name, 'code': code};
  }

  factory EditCategoryModel.fromMap(Map<String, dynamic> map) {
    return EditCategoryModel(
      id: map['id'] as String,
      name: map['name'] != null ? map['name'] as String : null,
      code: map['code'] != null ? map['code'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EditCategoryModel.fromJson(String source) =>
      EditCategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
