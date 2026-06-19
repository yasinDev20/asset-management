// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:assetmanagement/features/asset_category/domain/entities/add_category_entity.dart';
import 'package:equatable/equatable.dart';

class AddCategoryModel extends Equatable {
  final String name;
  final String code;

  const AddCategoryModel({required this.name, required this.code});

  @override
  List<Object> get props {
    return [name, code];
  }

  factory AddCategoryModel.fromEntity(AddCategoryEntity entity) {
    return AddCategoryModel(name: entity.name, code: entity.code);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'name': name, 'code': code};
  }

  factory AddCategoryModel.fromMap(Map<String, dynamic> map) {
    return AddCategoryModel(
      name: map['name'] as String,
      code: map['code'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddCategoryModel.fromJson(String source) =>
      AddCategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
