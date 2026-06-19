// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:assetmanagement/features/asset_brand/domain/entities/add_brand_entity.dart';
import 'package:equatable/equatable.dart';

class AddBrandModel extends Equatable {
  final String name;

  const AddBrandModel({required this.name});

  @override
  List<Object> get props => [name];

  factory AddBrandModel.fromEntity(AddBrandEntity entity) {
    return AddBrandModel(name: entity.name);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'name': name};
  }

  factory AddBrandModel.fromMap(Map<String, dynamic> map) {
    return AddBrandModel(name: map['name'] as String);
  }

  String toJson() => json.encode(toMap());

  factory AddBrandModel.fromJson(String source) =>
      AddBrandModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
