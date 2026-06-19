import 'dart:convert';

import 'package:assetmanagement/features/asset_brand/domain/entities/brand_detail_entity.dart';
import 'package:assetmanagement/features/asset_location/domain/entities/location_detail_entity.dart';
import 'package:equatable/equatable.dart';

class LocationDetailModel extends Equatable {
  final String id;
  final String ownerId;
  final String name;

  const LocationDetailModel({
    required this.id,
    required this.ownerId,
    required this.name,
  });

  @override
  List<Object> get props => [id, ownerId, name];

  LocationDetailEntity toEntity() {
    return LocationDetailEntity(id: id, ownerId: ownerId, name: name);
  }

  factory LocationDetailModel.fromEntity(LocationDetailEntity entity) {
    return LocationDetailModel(
      id: entity.id,
      ownerId: entity.ownerId,
      name: entity.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'owner_id': ownerId, 'name': name};
  }

  factory LocationDetailModel.fromMap(Map<String, dynamic> map) {
    return LocationDetailModel(
      id: map['id'] as String,
      ownerId: map['owner_id'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationDetailModel.fromJson(String source) =>
      LocationDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
