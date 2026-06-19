import 'dart:convert';

import 'package:assetmanagement/features/asset_location/domain/entities/add_location_entity%20.dart';
import 'package:equatable/equatable.dart';

class AddLocationModel extends Equatable {
  final String name;

  const AddLocationModel({required this.name});

  @override
  List<Object> get props => [name];

  factory AddLocationModel.fromEntity(AddLocationEntity entity) {
    return AddLocationModel(name: entity.name);
  }


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
    };
  }

  factory AddLocationModel.fromMap(Map<String, dynamic> map) {
    return AddLocationModel(
      name: map['name'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddLocationModel.fromJson(String source) => AddLocationModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
