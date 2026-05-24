// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:assetmanagement/features/asset/data/models/asset_ref_model.dart';
import 'package:assetmanagement/features/asset/domain/entities/brand_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/category_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/location_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:assetmanagement/features/asset/data/models/file_model.dart';
import 'package:assetmanagement/features/asset/data/models/service_schedule_model.dart';
import 'package:assetmanagement/features/asset/domain/entities/edit_asset_entity.dart';

class EditAssetModel extends Equatable {
  final String id;
  final FileModel? imageFile;
  final String? serialNumber;
  final String? name;
  final BrandEntity? brand;
  final CategoryEntity? category;
  final int? price;
  final int? productionYear;
  final LocationEntity? location;
  final String? status;
  final String? vendor;
  final int? purchaseYear;
  final int? warrantyEndYear;
  final List<ServiceScheduleModel>? serviceSchedules;
  final AssetRefModel? assetParent;
  final List<AssetRefModel>? assetChilds;
  final FileModel? invoiceFile;
  final String? notes;

  const EditAssetModel({
    required this.imageFile,
    required this.serialNumber,
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
    required this.assetChilds,
    required this.invoiceFile,
    required this.notes,
    required this.id,
  });

  @override
  List<Object> get props {
    return [
      ?serialNumber,
      ?imageFile,
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
      ?assetChilds,
      ?invoiceFile,
      ?notes,
    ];
  }

  factory EditAssetModel.fromEntity(EditAssetEntity entity) {
    return EditAssetModel(
      id: entity.id,
      imageFile: entity.imageFile != null
          ? FileModel.fromEntity(entity.imageFile!)
          : null,
      serialNumber: entity.serialNumber,
      name: entity.name,
      brand: entity.brand,
      category: entity.category,
      price: entity.price,
      productionYear: entity.productionYear,
      location: entity.location,
      status: entity.status,
      vendor: entity.vendor,
      purchaseYear: entity.purchaseYear,
      warrantyEndYear: entity.warrantyEndYear,
      serviceSchedules: entity.serviceSchedules
          ?.map((e) => ServiceScheduleModel.fromEntity(e))
          .toList(),
      assetParent: entity.assetParent != null ? AssetRefModel.formEntity(entity.assetParent!) : null,
      assetChilds: entity.assetChilds?.map((e) => AssetRefModel.formEntity(e)).toList(),
      invoiceFile: entity.invoiceFile != null
          ? FileModel.fromEntity(entity.invoiceFile!)
          : null,
      notes: entity.notes,
    );
  }

  EditAssetEntity toEntity() {
    return EditAssetEntity(
      id: id,
      imageFile: imageFile?.toEntity(),
      serialNumber: serialNumber,
      name: name,
      brand: brand,
      category: category,
      price: price,
      productionYear: productionYear,
      location: location,
      status: status,
      vendor: vendor,
      purchaseYear: purchaseYear,
      warrantyEndYear: warrantyEndYear,
      serviceSchedules: serviceSchedules?.map((e) => e.toEntity()).toList(),
      assetParent: assetParent?.toEntity(),
      assetChilds: assetChilds?.map((e) => e.toEntity()).toList(),
      invoiceFile: invoiceFile?.toEntity(),
      notes: notes,
    );
  }

  Map<String, dynamic> toUpdateMap(EditAssetModel originalAssetModel) {
    return <String, dynamic>{
      if (serialNumber != originalAssetModel.serialNumber)
        'serial_number': serialNumber,
      if (name != originalAssetModel.name) 'name': name,
      if (brand?.id != originalAssetModel.brand?.id) 'brand_id': brand?.id,
      if (category?.id != originalAssetModel.category?.id)
        'category_id': category?.id,
      if (price != originalAssetModel.price) 'price': price,
      if (productionYear != originalAssetModel.productionYear)
        'production_year': productionYear,
      if (location?.id != originalAssetModel.location?.id)
        'location_id': location?.id,
      if (status != originalAssetModel.status) 'status': status,
      if (vendor != originalAssetModel.vendor) 'vendor': vendor,
      if (purchaseYear != originalAssetModel.purchaseYear)
        'purchase_year': purchaseYear,
      if (warrantyEndYear != originalAssetModel.warrantyEndYear)
        'warranty_end_year': warrantyEndYear,
      if (!listEquals(serviceSchedules, originalAssetModel.serviceSchedules))
        'service_schedules': serviceSchedules?.map((x) => x.toMap()).toList(),
      if (assetParent != originalAssetModel.assetParent)
        'asset_parent_id': assetParent,
      if (!listEquals(assetChilds, originalAssetModel.assetChilds))
        'asset_child_ids': assetChilds,
      if (notes != originalAssetModel.notes) 'notes': notes,
    };
  }

  // factory EditAssetModel.fromMap(Map<String, dynamic> map) {
  //   return EditAssetModel(
  //     imageFile: map['imageFile'] != null ? FileModel.fromMap(map['imageFile'] as Map<String,dynamic>) : null,
  //     serialNumber: map['serialNumber'] != null ? map['serialNumber'] as String : null,
  //     name: map['name'] != null ? map['name'] as String : null,
  //     brandId: map['brandId'] != null ? map['brandId'] as String : null,
  //     categoryId: map['categoryId'] != null ? map['categoryId'] as String : null,
  //     price: map['price'] != null ? map['price'] as int : null,
  //     productionYear: map['productionYear'] != null ? map['productionYear'] as int : null,
  //     locationId: map['locationId'] != null ? map['locationId'] as String : null,
  //     status: map['status'] != null ? map['status'] as String : null,
  //     vendor: map['vendor'] != null ? map['vendor'] as String : null,
  //     purchaseYear: map['purchaseYear'] != null ? map['purchaseYear'] as int : null,
  //     warrantyEndYear: map['warrantyEndYear'] != null ? map['warrantyEndYear'] as int : null,
  //     serviceSchedules: map['serviceSchedules'] != null ? List<ServiceScheduleModel>.from((map['serviceSchedules'] as List<int>).map<ServiceScheduleModel?>((x) => ServiceScheduleModel.fromMap(x as Map<String,dynamic>),),) : null,
  //     assetParent: map['assetParent'] != null ? map['assetParent'] as String : null,
  //     assetChilds: map['assetChilds'] != null ? List<String>.from((map['assetChilds'] as List<String>) : null,
  //     invoiceFile: map['invoiceFile'] != null ? FileModel.fromMap(map['invoiceFile'] as Map<String,dynamic>) : null,
  //     notes: map['notes'] != null ? map['notes'] as String : null,
  //   );
  // }

  // String toUpdateJson() => json.encode(toUpdateMap());

  // factory EditAssetModel.fromJson(String source) => EditAssetModel.fromMap(json.decode(source) as Map<String, dynamic>);

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'serialNumber': serialNumber,
  //     'name': name,
  //     'brandId': brandId,
  //     'categoryId': categoryId,
  //     'price': price,
  //     'productionYear': productionYear,
  //     'locationId': locationId,
  //     'status': status,
  //     'vendor': vendor,
  //     'purchaseYear': purchaseYear,
  //     'warrantyEndYear': warrantyEndYear,
  //     'serviceSchedules': serviceSchedules?.map((x) => x.toMap()).toList(),
  //     'assetParentId': assetParent,
  //     'assetChilds': assetChilds,
  //     'notes': notes,
  //   };
  // }
}
