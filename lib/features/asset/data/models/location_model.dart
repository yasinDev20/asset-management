import 'dart:convert';

import 'package:assetmanagement/features/asset/domain/entities/location_entity.dart';
import 'package:equatable/equatable.dart';

class LocationModel extends Equatable {
  final String id;
  final String ownerId;
  final String name;
  const LocationModel({
    required this.id,
    required this.ownerId,
    required this.name,
  });

  @override
  List<Object> get props => [id, ownerId, name];
  LocationEntity toEntity() {
    return LocationEntity(id: id, ownerId: ownerId, name: name);
  }

  factory LocationModel.fromEntity(LocationEntity entity) {
    return LocationModel(
      id: entity.id,
      ownerId: entity.ownerId,
      name: entity.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'ownerId': ownerId, 'name': name};
  }

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      id: map['id'] as String,
      ownerId: map['ownerId'] as String,
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationModel.fromJson(String source) =>
      LocationModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
