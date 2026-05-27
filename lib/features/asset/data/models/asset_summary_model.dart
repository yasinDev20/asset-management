import 'dart:convert';

import 'package:assetmanagement/features/asset/data/models/service_schedule_model.dart';
import 'package:equatable/equatable.dart';

import 'package:assetmanagement/features/asset/domain/entities/asset_lite_entity.dart';

class AssetLiteModel extends Equatable {
  final String id;
  final String status;
  final String image;
  final String categoryName;
  final String qrCode;
  final String brandName;
  final String name;
  final String location;
  final DateTime? nextServiceSchedule;
  const AssetLiteModel({
    required this.id,
    required this.status,
    required this.image,
    required this.categoryName,
    required this.qrCode,
    required this.brandName,
    required this.name,
    required this.location,
    required this.nextServiceSchedule,
  });

  @override
  List<Object> get props {
    return [
      id,
      status,
      image,
      categoryName,
      qrCode,
      brandName,
      name,
      location,
      ?nextServiceSchedule,
    ];
  }

  AssetLiteEntity toEntity({required String imageUrl}) {
    return AssetLiteEntity(
      id: id,
      status: status,
      image: imageUrl,
      categoryName: categoryName,
      qrCode: qrCode,
      brandName: brandName,
      name: name,
      location: location,
      nextServiceSchedule: nextServiceSchedule,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'status': status,
      'image': image,
      'category_name': categoryName,
      'qr_code': qrCode,
      'brand_name': brandName,
      'name': name,
      'location': location,
      'service_schedules': nextServiceSchedule,
    };
  }

  factory AssetLiteModel.fromMap(Map<String, dynamic> map) {
    final serviceSchedules = map['service_schedules'] != null
        ? (map['service_schedules'] as List)
              .map((e) => ServiceScheduleModel.fromMap(e))
              .toList()
        : null;
    final now = DateTime.now().toUtc();
    final today = DateTime(now.year, now.month, now.day);
    DateTime? nextSchedule;
    if (serviceSchedules != null) {
      for (final element in serviceSchedules) {
        final raw = element.time;
        DateTime candidate;

        // Feb 29 will be auto-normalized to Mar 1 on non-leap years (intended behavior)
        if (element.type == 'yearly') {
          candidate = DateTime(today.year, raw.month, raw.day);

          //!candidate.isAfter(today) same with "<="
          if (!candidate.isAfter(today)) {
            candidate = DateTime(today.year + 1, raw.month, raw.day);
          }
        } else if (element.type == 'monthly') {
          candidate = DateTime(today.year, today.month, raw.day);

          if (!candidate.isAfter(today)) {
            candidate = DateTime(today.year, today.month + 1, raw.day);
          }
        } else {
          continue;
        }

        //compare for the nearest date
        if (nextSchedule == null || candidate.isBefore(nextSchedule)) {
          nextSchedule = candidate;
        }
      }
    }

    final nextServiceScheduleChose = nextSchedule;

    return AssetLiteModel(
      id: map['id'] as String,
      status: map['status'] as String,
      image: map['image_path'] as String,
      categoryName: map['category_name']['name'] as String,
      qrCode: map['qr_code'] as String,
      brandName: map['brand_name']['name'] as String,
      name: map['name'] as String,
      location: map['location']['name'] as String,
      nextServiceSchedule: nextServiceScheduleChose,
    );
  }

  String toJson() => json.encode(toMap());

  factory AssetLiteModel.fromJson(String source) =>
      AssetLiteModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
