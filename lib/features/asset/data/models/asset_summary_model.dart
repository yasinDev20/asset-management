import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:assetmanagement/features/asset/domain/entities/asset_summary_entity.dart';

class AssetSummaryModel extends Equatable {
  final String id;
  final String status;
  final String image;
  final String categoryName;
  final String qrCode;
  final String brandName;
  final String name;
  final String location;
  final String? nextServiceSchedule;
  const AssetSummaryModel({
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

  AssetSummaryEntity toEntity() {
    return AssetSummaryEntity(
      id: id,
      status: status,
      image: image,
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
      'categoryName': categoryName,
      'qrCode': qrCode,
      'brandName': brandName,
      'name': name,
      'location': location,
      'serviceSchedules': nextServiceSchedule,
    };
  }

  factory AssetSummaryModel.fromMap(Map<String, dynamic> map) {
    final serviceSchedules = (map['serviceSchedules'] as List);
    final now = DateTime(2026, 1, 24, 24);
    String? nextServiceScheduleChose;

    //kalau sama  pilih
    //kalau lebih besar pilih dan stop
    for (var element in serviceSchedules) {
      final schedule = DateTime.parse(element);

      if (now.isBefore(schedule)) {
        nextServiceScheduleChose = element;

        break;
      }
    }

    return AssetSummaryModel(
      id: map['id'] as String,
      status: map['status'] as String,
      image: map['image'] as String,
      categoryName: map['categoryName']['name'] as String,
      qrCode: map['qrCode'] as String,
      brandName: map['brandName']['name'] as String,
      name: map['name'] as String,
      location: map['location']['name'] as String,
      nextServiceSchedule: nextServiceScheduleChose,
    );
  }

  String toJson() => json.encode(toMap());

  factory AssetSummaryModel.fromJson(String source) =>
      AssetSummaryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
