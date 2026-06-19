import 'dart:convert';

import 'package:assetmanagement/features/asset/data/models/asset_ref_model.dart';
import 'package:assetmanagement/features/asset_brand/data/models/brand_detail_model.dart';
import 'package:assetmanagement/features/asset_category/data/models/category_detail_model.dart';
import 'package:assetmanagement/features/asset/data/models/service_schedule_model.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_detail_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_ref_entity.dart';
import 'package:assetmanagement/features/asset_location/data/models/location_detail_model.dart';
import 'package:assetmanagement/features/authentication/data/models/user_model.dart';
import 'package:equatable/equatable.dart';

class AssetDetailModel extends Equatable {
  final String id;
  final String ownerId;
  final UserModel owner;
  final String imagePath;
  final String qrCode;
  final String? serialNumber;
  final String name;
  final String brandId;
  final BrandDetailModel brand;
  final String categoryId;
  final CategoryDetailModel category;
  final int price;
  final int productionYear;
  final String locationId;
  final LocationDetailModel location;
  final String status;
  final String vendor;
  final int purchaseYear;
  final int? warrantyEndYear;
  final List<ServiceScheduleModel>? serviceSchedules;
  final AssetRefModel? assetParent;
  final List<String>? assetChildIds;
  final String? invoicePath;
  final String? notes;
  final String createdAt;
  final String? updatedAt;

  const AssetDetailModel({
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
    required this.assetChildIds,
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
      imagePath,
      qrCode,
      ?serialNumber,
      name,
      brandId,
      categoryId,
      price,
      productionYear,
      locationId,
      status,
      vendor,
      purchaseYear,
      ?warrantyEndYear,
      ?serviceSchedules,
      ?assetParent,
      ?assetChildIds,
      ?invoicePath,
      ?notes,
      createdAt,
      ?updatedAt,
    ];
  }

  AssetDetailEntity toEntity({required List<AssetRefEntity>? assetChildData}) {
    return AssetDetailEntity(
      id: id,
      ownerId: ownerId,
      owner: owner.toEntity(),
      imagePath: imagePath,
      qrCode: qrCode,
      serialNumber: serialNumber,
      name: name,
      brandId: brandId,
      brand: brand.toEntity(),
      categoryId: categoryId,
      category: category.toEntity(),
      price: price,
      productionYear: productionYear,
      locationId: locationId,
      location: location.toEntity(),
      status: status,
      vendor: vendor,
      purchaseYear: purchaseYear,
      warrantyEndYear: warrantyEndYear,
      serviceSchedules: serviceSchedules?.map((e) => e.toEntity()).toList(),
      assetParent: assetParent?.toEntity(),
      assetChilds: assetChildData,
      invoicePath: invoicePath,
      notes: notes,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory AssetDetailModel.fromEntity(AssetDetailEntity entity) {
    return AssetDetailModel(
      id: entity.id,
      ownerId: entity.ownerId,
      owner: UserModel.fromEntity(entity.owner),
      imagePath: entity.imagePath,
      qrCode: entity.qrCode,
      serialNumber: entity.serialNumber,
      name: entity.name,
      brandId: entity.brandId,
      brand: BrandDetailModel.fromEntity(entity.brand),
      categoryId: entity.categoryId,
      category: CategoryDetailModel.fromEntity(entity.category),
      price: entity.price,
      productionYear: entity.productionYear,
      locationId: entity.locationId,
      location: LocationDetailModel.fromEntity(entity.location),
      status: entity.status,
      vendor: entity.vendor,
      purchaseYear: entity.purchaseYear,
      warrantyEndYear: entity.warrantyEndYear,
      serviceSchedules: entity.serviceSchedules
          ?.map((e) => ServiceScheduleModel.fromEntity(e))
          .toList(),
      assetParent: entity.assetParent != null
          ? AssetRefModel.formEntity(entity.assetParent!)
          : null,
      assetChildIds: entity.assetChilds?.map((e) => e.id).toList(),
      invoicePath: entity.invoicePath,
      notes: entity.notes,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'owner_id': ownerId,
      'image_path': imagePath,
      'qr_code': qrCode,
      'serial_number': serialNumber,
      'name': name,
      'brand_id': brandId,
      'category_id': categoryId,
      'price': price,
      'production_year': productionYear,
      'location_id': locationId,
      'status': status,
      'vendor': vendor,
      'purchase_year': purchaseYear,
      'warranty_end_year': warrantyEndYear,
      'service_schedules': serviceSchedules?.map((e) => e.toMap()).toList(),
      'parent_id': assetParent,
      'asset_child_ids': assetChildIds,
      'invoice_path': invoicePath,
      'notes': notes,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory AssetDetailModel.fromMap(Map<String, dynamic> map) {
    return AssetDetailModel(
      id: map['id'] as String,
      ownerId: map['owner_id'] as String,
      owner: UserModel.fromMap(map['owner']),
      imagePath: map['image_path'] as String,
      qrCode: map['qr_code'] as String,
      serialNumber: map['serial_number'] != null
          ? map['serial_number'] as String
          : null,
      name: map['name'] as String,
      brandId: map['brand_id'] as String,
      brand: BrandDetailModel.fromMap(map['brand']),
      categoryId: map['category_id'] as String,
      category: CategoryDetailModel.fromMap(map['category']),
      price: map['price'] as int,
      productionYear: map['production_year'] as int,
      locationId: map['location_id'] as String,
      location: LocationDetailModel.fromMap(map['location']),
      status: map['status'] as String,
      vendor: map['vendor'] as String,
      purchaseYear: map['purchase_year'] as int,
      warrantyEndYear: map['warranty_end_year'] != null
          ? map['warranty_end_year'] as int
          : null,
      serviceSchedules: map['service_schedules'] != null
          ? List.from(
              (map['service_schedules'] as List).map(
                (e) => ServiceScheduleModel.fromMap(e),
              ),
            )
          : null,
      assetParent: map['asset_parent'] != null
          ? AssetRefModel.fromMap(map['asset_parent'])
          : null,
      assetChildIds: map['asset_child_ids'] != null
          ? List.from((map['asset_child_ids'] as List))
          : null,
      invoicePath: map['invoice_path'] != null
          ? map['invoice_path'] as String
          : null,
      notes: map['notes'] != null ? map['notes'] as String : null,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] != null ? map['updated_at'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AssetDetailModel.fromJson(String source) =>
      AssetDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
