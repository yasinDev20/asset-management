import 'dart:convert';

import 'package:assetmanagement/features/asset/domain/entities/service_schedule_entity.dart';
import 'package:equatable/equatable.dart';

class ServiceScheduleModel extends Equatable {
  final String title;
  final String type;
  final DateTime time;

  const ServiceScheduleModel({
    required this.title,
    required this.type,
    required this.time,
  });

  @override
  List<Object> get props => [title, type, time];

  ServiceScheduleEntity toEntity() {
    return ServiceScheduleEntity(title: title, type: type, time: time);
  }

  factory ServiceScheduleModel.fromEntity(
    ServiceScheduleEntity serviceScheduleEntity,
  ) {
    return ServiceScheduleModel(
      title: serviceScheduleEntity.title,
      type: serviceScheduleEntity.type,
      time: serviceScheduleEntity.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'type': type,
      'time': time.toIso8601String(),
    };
  }

  factory ServiceScheduleModel.fromMap(Map<String, dynamic> map) {
    return ServiceScheduleModel(
      title: map['title'] as String,
      type: map['type'] as String,
      time: DateTime.parse(map['time']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceScheduleModel.fromJson(String source) =>
      ServiceScheduleModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
