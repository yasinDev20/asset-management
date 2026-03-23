import 'dart:convert';

import 'package:assetmanagement/features/asset/data/models/brand_model.dart';
import 'package:assetmanagement/features/asset/data/models/category_model.dart';
import 'package:assetmanagement/features/asset/data/models/location_model.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_detail_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_ref_entity.dart';
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
  final BrandModel brand;
  final String categoryId;
  final CategoryModel category;
  final int price;
  final int productionYear;
  final String locationId;
  final LocationModel location;
  final String status;
  final String vendor;
  final int purchaseYear;
  final int? warrantyEndYear;
  final List<Map<String, dynamic>>? serviceSchedules;
  final String? assetParent;
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

  AssetDetailEntity toEntity({
    required List<AssetRefEntity>? assetChildData,
    required AssetRefEntity? assetParentData,
  }) {
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
      serviceSchedules: serviceSchedules,
      assetParent: assetParentData,
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
      brand: BrandModel.fromEntity(entity.brand),
      categoryId: entity.categoryId,
      category: CategoryModel.fromEntity(entity.category),
      price: entity.price,
      productionYear: entity.productionYear,
      locationId: entity.locationId,
      location: LocationModel.fromEntity(entity.location),
      status: entity.status,
      vendor: entity.vendor,
      purchaseYear: entity.purchaseYear,
      warrantyEndYear: entity.warrantyEndYear,
      serviceSchedules: entity.serviceSchedules,
      assetParent: entity.assetParent?.id,
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
      'ownerId': ownerId,
      'image': imagePath,
      'qrCode': qrCode,
      'serialNumber': serialNumber,
      'name': name,
      'brandId': brandId,
      'categoryId': categoryId,
      'price': price,
      'productionYear': productionYear,
      'locationId': locationId,
      'status': status,
      'vendor': vendor,
      'purchaseYear': purchaseYear,
      'warrantyEndYear': warrantyEndYear,
      'serviceSchedules': serviceSchedules,
      'assetParent': assetParent,
      'assetChild': assetChildIds,
      'invoice': invoicePath,
      'notes': notes,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory AssetDetailModel.fromMap(Map<String, dynamic> map) {
    return AssetDetailModel(
      id: map['id'] as String,
      ownerId: map['ownerId'] as String,
      owner: UserModel.fromMap(map['owner']),
      imagePath: map['image'] as String,
      qrCode: map['qrCode'] as String,
      serialNumber: map['serialNumber'] != null
          ? map['serialNumber'] as String
          : null,
      name: map['name'] as String,
      brandId: map['brandId'] as String,
      brand: BrandModel.fromMap(map['brand']),
      categoryId: map['categoryId'] as String,
      category: CategoryModel.fromMap(map['category']),
      price: map['price'] as int,
      productionYear: map['productionYear'] as int,
      locationId: map['locationId'] as String,
      location: LocationModel.fromMap(map['location']),
      status: map['status'] as String,
      vendor: map['vendor'] as String,
      purchaseYear: map['purchaseYear'] as int,
      warrantyEndYear: map['warrantyEndYear'] != null
          ? map['warrantyEndYear'] as int
          : null,
      serviceSchedules: map['serviceSchedules'] != null
          ? List<Map<String, dynamic>>.from(
              (map['serviceSchedules'] as List).map(
                (e) => {
                  'time': DateTime.parse(e['time'] as String).toLocal(),
                  'type': e['type'] as String,
                  'title': e['title'] as String,
                },
              ),
            )
          : null,
      assetParent: map['assetParent'] != null
          ? map['assetParent'] as String
          : null,
      assetChildIds: map['assetChilds'] != null
          ? List.from((map['assetChilds'] as List))
          : null,
      invoicePath: map['invoice'] != null ? map['invoice'] as String : null,
      notes: map['notes'] != null ? map['notes'] as String : null,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AssetDetailModel.fromJson(String source) =>
      AssetDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);
}


