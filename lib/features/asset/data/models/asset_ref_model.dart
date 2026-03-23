// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:assetmanagement/features/asset/domain/entities/asset_ref_entity.dart';
import 'package:equatable/equatable.dart';

class AssetRefModel extends Equatable {
  final String id;
  final String categoryName;
  final String qrCode;
  final String brandName;
  final String name;

  const AssetRefModel({
    required this.id,
    required this.categoryName,
    required this.qrCode,
    required this.brandName,
    required this.name,
  });

  @override
  List<Object> get props {
    return [id, categoryName, qrCode, brandName, name];
  }

  AssetRefEntity toEntity() {
    return AssetRefEntity(
      id: id,
      categoryName: categoryName,
      qrCode: qrCode,
      brandName: brandName,
      name: name,
    );
  }

  factory AssetRefModel.formEntity(AssetRefEntity entity) {
    return AssetRefModel(
      id: entity.id,
      categoryName: entity.categoryName,
      qrCode: entity.qrCode,
      brandName: entity.brandName,
      name: entity.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'categoryName': categoryName,
      'qrCode': qrCode,
      'brandName': brandName,
      'name': name,
    };
  }

  factory AssetRefModel.fromMap(Map<String, dynamic> map) {
    return AssetRefModel(
      id: map['id'] as String,
      categoryName: map['category']['name'] as String,
      qrCode: map['qrCode'] as String,
      brandName: map['brand']['name'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AssetRefModel.fromJson(String source) =>
      AssetRefModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
