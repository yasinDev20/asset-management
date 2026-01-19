import 'dart:convert';

import 'package:assetmanagement/features/asset/data/models/brand_model.dart';
import 'package:assetmanagement/features/asset/data/models/category_model.dart';
import 'package:assetmanagement/features/asset/data/models/location_model.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_entity.dart';
import 'package:assetmanagement/features/authentication/data/models/user_model.dart';
import 'package:equatable/equatable.dart';

class AssetModel extends Equatable {
  final String id;
  final String ownerId;
  final UserModel owner;
  final String image;
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
  final List<String>? serviceSchedules;
  final String? assetParent;
  final List<String>? assetChild;
  final String? invoice;
  final String? notes;
  final String createdAt;
  final String? updatedAt;

  const AssetModel({
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
      image,
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
      ?assetChild,
      ?invoice,
      ?notes,
      createdAt,
      ?updatedAt,
    ];
  }

  AssetEntity toEntity() {
    return AssetEntity(
      id: id,
      ownerId: ownerId,
      owner: owner.toEntity(),
      image: image,
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
      assetParent: assetParent,
      assetChild: assetChild,
      invoice: invoice,
      notes: notes,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  factory AssetModel.fromEntity(AssetEntity entity) {
    return AssetModel(
      id: entity.id,
      ownerId: entity.ownerId,
      owner: UserModel.fromEntity(entity.owner),
      image: entity.image,
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
      assetParent: entity.assetParent,
      assetChild: entity.assetChild,
      invoice: entity.invoice,
      notes: entity.notes,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'ownerId': ownerId,
      'image': image,
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
      'assetChild': assetChild,
      'invoice': invoice,
      'notes': notes,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory AssetModel.fromMap(Map<String, dynamic> map) {
    return AssetModel(
      id: map['id'] as String,
      ownerId: map['ownerId'] as String,
      owner:  UserModel.fromMap(map['owner']),
      image: map['image'] as String,
      qrCode: map['qrCode'] as String,
      serialNumber: map['serialNumber'] != null
          ? map['serialNumber'] as String
          : null,
      name: map['name'] as String,
      brandId: map['brandId'] as String,
      brand: BrandModel.fromMap( map['brand']),
      categoryId:  map['categoryId'] as String,
      category: CategoryModel.fromMap(map['category']),
      price: map['price'] as int,
      productionYear: map['productionYear'] as int,
      locationId: map['locationId'] as String,
      location:LocationModel.fromMap( map['location']),
      status: map['status'] as String,
      vendor: map['vendor'] as String,
      purchaseYear: map['purchaseYear'] as int,
      warrantyEndYear: map['warrantyEndYear'] != null
          ? map['warrantyEndYear'] as int
          : null,
      serviceSchedules: map['serviceSchedules'] != null
          ? List.from((map['serviceSchedules'] as List))
          : null,
      assetParent: map['assetParent'] != null
          ? map['assetParent'] as String
          : null,
      assetChild: map['assetChild'] != null
          ? List<String>.from((map['assetChild'] as List<String>))
          : null,
      invoice: map['invoice'] != null ? map['invoice'] as String : null,
      notes: map['notes'] != null ? map['notes'] as String : null,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AssetModel.fromJson(String source) =>
      AssetModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
