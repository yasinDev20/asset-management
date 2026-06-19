import 'package:assetmanagement/features/asset/domain/entities/asset_ref_entity.dart';
import 'package:assetmanagement/features/asset_brand/domain/entities/brand_detail_entity.dart';
import 'package:assetmanagement/features/asset_category/domain/entities/category_detail_entity.dart';
import 'package:assetmanagement/features/asset_location/domain/entities/location_detail_entity.dart';
import 'package:equatable/equatable.dart';

import 'package:assetmanagement/features/asset/domain/entities/service_schedule_entity.dart';

class AssetTemplateEntity extends Equatable {
  final String? id;
  final String templateName;
  final String assetId;
  final String? name;
  final BrandDetailEntity? brand;
  final CategoryDetailEntity? category;
  final int? price;
  final int? productionYear;
  final LocationDetailEntity? location;
  final String? status;
  final String? vendor;
  final int? purchaseYear;
  final int? warrantyEndYear;
  final List<ServiceScheduleEntity>? serviceSchedules;
  final AssetRefEntity? assetParent;
  final String? notes;

  const AssetTemplateEntity({
    this.id,
    required this.templateName,
    required this.assetId,
    required this.name,
    required this.brand,
    required this.category,
    required this.price,
    required this.productionYear,
    required this.location,
    required this.status,
    required this.vendor,
    required this.purchaseYear,
    required this.warrantyEndYear,
    required this.serviceSchedules,
    required this.assetParent,
    required this.notes,
  });

  @override
  List<Object> get props {
    return [
      ?id,
      templateName,
      assetId,
      ?name,
      ?brand,
      ?category,
      ?price,
      ?productionYear,
      ?location,
      ?status,
      ?vendor,
      ?purchaseYear,
      ?warrantyEndYear,
      ?serviceSchedules,
      ?assetParent,
      ?notes,
    ];
  }
}
