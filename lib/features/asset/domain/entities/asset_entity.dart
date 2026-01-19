// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:assetmanagement/features/asset/domain/entities/brand_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/category_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/location_entity.dart';
import 'package:assetmanagement/features/authentication/domain/entities/user_entity.dart';

class AssetEntity extends Equatable {
   final String id;
  final String ownerId;
  final UserEntity owner;
  final String image;
  final String qrCode;
  final String? serialNumber;
  final String name;
  final String brandId;
  final BrandEntity brand;
  final String categoryId;
  final CategoryEntity category;
  final int price;
  final int productionYear;
  final String locationId;
  final LocationEntity location;
  final String status;
  final String vendor;
  final int purchaseYear;
  final int? warrantyEndYear;
  final List<String>? serviceSchedules;
  final String? assetParent;
  final List<String>? assetChild;
  final String? invoice;
  final String? notes;
  final String createdAt;
  final String? updatedAt;

  const AssetEntity({
    required this.id,
    required this.ownerId,
    required this.image,
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
    required this.assetChild,
    required this.invoice,
    required this.notes,
    required this.createdAt,
    required this.updatedAt, required this.owner, required this.brand, required this.category, required this.location,
  });

  

  

  @override
  List<Object> get props {
    return [
      id,
      ownerId,
      owner,
      image,
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
      ?assetChild,
      ?invoice,
      ?notes,
      createdAt,
      ?updatedAt,
    ];
  }
}
