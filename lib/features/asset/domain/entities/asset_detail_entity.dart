// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:assetmanagement/features/asset/domain/entities/asset_ref_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/service_schedule_entity.dart';
import 'package:equatable/equatable.dart';

import 'package:assetmanagement/features/asset_brand/domain/entities/brand_detail_entity.dart';
import 'package:assetmanagement/features/asset_category/domain/entities/category_detail_entity.dart';
import 'package:assetmanagement/features/asset_location/domain/entities/location_detail_entity.dart';
import 'package:assetmanagement/features/authentication/domain/entities/user_entity.dart';

class AssetDetailEntity extends Equatable {
  final String id;
  final String ownerId;
  final UserEntity owner;
  final String imagePath;
  final String qrCode;
  final String? serialNumber;
  final String name;
  final String brandId;
  final BrandDetailEntity brand;
  final String categoryId;
  final CategoryDetailEntity category;
  final int price;
  final int productionYear;
  final String locationId;
  final LocationDetailEntity location;
  final String status;
  final String vendor;
  final int purchaseYear;
  final int? warrantyEndYear;
  final List<ServiceScheduleEntity>? serviceSchedules;
  final AssetRefEntity? assetParent;
  final String? invoicePath;
  final String? notes;
  final String createdAt;
  final String? updatedAt;

  const AssetDetailEntity({
    required this.id,
    required this.ownerId,
    required this.imagePath,
    required this.qrCode,
    required this.serialNumber,
    required this.name,
    required this.brandId,
    required this.categoryId,
    required this.price,
    required this.productionYear,
    required this.locationId,
    required this.status,
    required this.vendor,
    required this.purchaseYear,
    required this.warrantyEndYear,
    required this.serviceSchedules,
    required this.assetParent,
    required this.invoicePath,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
    required this.owner,
    required this.brand,
    required this.category,
    required this.location,
  });

  @override
  List<Object> get props {
    return [
      id,
      ownerId,
      owner,
      imagePath,
      qrCode,
      ?serialNumber,
      name,
      brandId,
      brand,
      categoryId,
      category,
      price,
      productionYear,
      locationId,
      location,
      status,
      vendor,
      purchaseYear,
      ?warrantyEndYear,
      ?serviceSchedules,
      ?assetParent,
      ?invoicePath,
      ?notes,
      createdAt,
      ?updatedAt,
    ];
  }
}
