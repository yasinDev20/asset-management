// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:assetmanagement/features/asset_location/domain/entities/edit_location_entity.dart';
import 'package:equatable/equatable.dart';

class EditLocationModel extends Equatable {
  final String id;
  final String? name;

  const EditLocationModel({required this.id, this.name});

  @override
  List<Object> get props => [?name];

  factory EditLocationModel.fromEntity(EditLocationEntity entity) {
    return EditLocationModel(id: entity.id, name: entity.name);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'name': name};
  }

  factory EditLocationModel.fromMap(Map<String, dynamic> map) {
    return EditLocationModel(
      id: map['id'] as String,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory EditLocationModel.fromJson(String source) =>
      EditLocationModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
