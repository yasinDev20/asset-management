import 'dart:convert';

import 'package:assetmanagement/features/asset_category/data/models/category_detail_model.dart';
import 'package:assetmanagement/features/asset/data/models/service_schedule_model.dart';
import 'package:equatable/equatable.dart';

import 'package:assetmanagement/features/asset/data/models/file_model.dart';
import 'package:assetmanagement/features/asset/domain/entities/add_asset_entity.dart';

class AddAssetModel extends Equatable {
  final String ownerId;
  final FileModel imageFile;
  final String? serialNumber;
  final String name;
  final String brandId;
  final CategoryDetailModel category;
  final int price;
  final int productionYear;
  final String locationId;
  final String status;
  final String vendor;
  final int purchaseYear;
  final int? warrantyEndYear;
  final List<ServiceScheduleModel>? serviceSchedules;
  final String? assetParentId;
  final List<String>? assetChildIds;
  final FileModel? invoiceFile;
  final String? notes;

  const AddAssetModel({
    required this.imageFile,
    required this.serialNumber,
    required this.name,
    required this.brandId,
    required this.category,
    required this.price,
    required this.productionYear,
    required this.locationId,
    required this.status,
    required this.vendor,
    required this.purchaseYear,
    required this.warrantyEndYear,
    required this.serviceSchedules,
    required this.assetParentId,
    required this.assetChildIds,
    required this.invoiceFile,
    required this.notes,
    required this.ownerId,
  });

  @override
  List<Object> get props {
    return [
      ?serialNumber,
      imageFile,
      name,
      brandId,
      category,
      price,
      productionYear,
      locationId,
      status,
      vendor,
      purchaseYear,
      ?warrantyEndYear,
      ?serviceSchedules,
      ?assetParentId,
      ?assetChildIds,
      ?invoiceFile,
      ?notes,
    ];
  }

  AddAssetEntity toEntity() {
    return AddAssetEntity(
      ownerId: ownerId,
      imageFile: imageFile.toEntity(),
      serialNumber: serialNumber,
      name: name,
      brandId: brandId,
      category: category.toEntity(),
      price: price,
      productionYear: productionYear,
      locationId: locationId,
      status: status,
      vendor: vendor,
      purchaseYear: purchaseYear,
      warrantyEndYear: warrantyEndYear,
      serviceSchedules: serviceSchedules?.map((e) => e.toEntity()).toList(),
      assetParent: assetParentId,
      assetChilds: assetChildIds,
      invoiceFile: invoiceFile?.toEntity(),
      notes: notes,
    );
  }

  factory AddAssetModel.fromEntity(AddAssetEntity addAssetEntity) {
    return AddAssetModel(
      ownerId: addAssetEntity.ownerId,
      imageFile: FileModel.fromEntity(addAssetEntity.imageFile),
      serialNumber: addAssetEntity.serialNumber,
      name: addAssetEntity.name,
      brandId: addAssetEntity.brandId,
      category: CategoryDetailModel.fromEntity(addAssetEntity.category),
      price: addAssetEntity.price,
      productionYear: addAssetEntity.productionYear,
      locationId: addAssetEntity.locationId,
      status: addAssetEntity.status,
      vendor: addAssetEntity.vendor,
      purchaseYear: addAssetEntity.purchaseYear,
      warrantyEndYear: addAssetEntity.warrantyEndYear,
      serviceSchedules: addAssetEntity.serviceSchedules
          ?.map((e) => ServiceScheduleModel.fromEntity(e))
          .toList(),
      assetParentId: addAssetEntity.assetParent,
      assetChildIds: addAssetEntity.assetChilds,
      invoiceFile: addAssetEntity.invoiceFile != null
          ? FileModel.fromEntity(addAssetEntity.invoiceFile!)
          : null,
      notes: addAssetEntity.notes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'owner_id': ownerId,
      'serial_number': serialNumber,
      'name': name,
      'brand_id': brandId,
      'category_id': category.id,
      'category_code': category.code,
      'price': price,
      'production_year': productionYear,
      'location_id': locationId,
      'status': status,
      'vendor': vendor,
      'purchase_year': purchaseYear,
      'warranty_end_year': warrantyEndYear,
      'service_schedules': serviceSchedules?.map((e) => e.toMap()).toList(),
      'parent_id': assetParentId,
      'asset_child_ids': assetChildIds,
      'notes': notes,
    };
  }

  // factory AddAssetModel.fromMap(Map<String, dynamic> map) {
  //   return AddAssetModel(
  //     imageFile: FileModel.fromMap(map['imageFile'] as Map<String, dynamic>),
  //     serialNumber: map['serialNumber'] != null
  //         ? map['serialNumber'] as String
  //         : null,
  //     name: map['name'] as String,
  //     brandId: map['brandId'] as String,
  //     categoryId: map['categoryId'] as String,
  //     price: map['price'] as int,
  //     productionYear: map['productionYear'] as int,
  //     locationId: map['locationId'] as String,
  //     status: map['status'] as String,
  //     vendor: map['vendor'] as String,
  //     purchaseYear: map['purchaseYear'] as int,
  //     warrantyEndYear: map['warrantyEndYear'] != null
  //         ? map['warrantyEndYear'] as int
  //         : null,
  //     serviceSchedules: map['serviceSchedules'] != null
  //         ? List<Map<String, dynamic>>.from(
  //             (map['serviceSchedules'] as List<int>).map<Map<String, dynamic>?>(
  //               (x) => x,
  //             ),
  //           )
  //         : null,
  //     assetParent: map['assetParent'] != null
  //         ? AssetRefEntity.fromMap(map['assetParent'] as Map<String, dynamic>)
  //         : null,
  //     assetChilds: map['assetChilds'] != null
  //         ? List<AssetRefEntity>.from(
  //             (map['assetChilds'] as List<int>).map<AssetRefEntity?>(
  //               (x) => AssetRefEntity.fromMap(x as Map<String, dynamic>),
  //             ),
  //           )
  //         : null,
  //     invoiceFile: map['invoiceFile'] != null
  //         ? FileEntity.fromMap(map['invoiceFile'] as Map<String, dynamic>)
  //         : null,
  //     notes: map['notes'] != null ? map['notes'] as String : null,
  //   );
  // }

  String toJson() => json.encode(toMap());

  // factory AddAssetModel.fromJson(String source) =>
  //     AddAssetModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
