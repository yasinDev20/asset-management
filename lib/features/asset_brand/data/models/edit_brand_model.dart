// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:assetmanagement/features/asset_brand/domain/entities/edit_brand_entity.dart';

class EditBrandModel extends Equatable {
  final String id;
  final String? name;

  const EditBrandModel({required this.id, this.name});

  @override
  List<Object> get props => [?name];

  factory EditBrandModel.fromEntity(EditBrandEntity entity) {
    return EditBrandModel(id: entity.id, name: entity.name);
  }


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory EditBrandModel.fromMap(Map<String, dynamic> map) {
    return EditBrandModel(
      id: map['id'] as String,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EditBrandModel.fromJson(String source) => EditBrandModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
