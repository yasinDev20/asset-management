// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:assetmanagement/features/asset/data/models/asset_ref_model.dart';
import 'package:assetmanagement/features/asset_brand/data/models/brand_detail_model.dart';
import 'package:assetmanagement/features/asset_category/data/models/category_detail_model.dart';
import 'package:assetmanagement/features/asset/data/models/service_schedule_model.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_template_entity.dart';
import 'package:assetmanagement/features/asset_location/data/models/location_detail_model.dart';
import 'package:equatable/equatable.dart';

class AssetTemplateModel extends Equatable {
  final String id;
  final String templateName;
  final String assetId;
  final String? name;
  final BrandDetailModel? brand;
  final CategoryDetailModel? category;
  final int? price;
  final int? productionYear;
  final LocationDetailModel? location;
  final String? status;
  final String? vendor;
  final int? purchaseYear;
  final int? warrantyEndYear;
  final List<ServiceScheduleModel>? serviceSchedules;
  final AssetRefModel? assetParent;
  final String? notes;

  const AssetTemplateModel({
    required this.id,
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
    required this.templateName,
  });

  @override
  List<Object> get props {
    return [
      templateName,
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

  factory AssetTemplateModel.fromEntity(AssetTemplateEntity entity) {
    return AssetTemplateModel(
      id: entity.assetId,
      assetId: entity.assetId,
      name: entity.name,
      brand: entity.brand != null
          ? BrandDetailModel.fromEntity(entity.brand!)
          : null,
      category: entity.category != null
          ? CategoryDetailModel.fromEntity(entity.category!)
          : null,
      price: entity.price,
      productionYear: entity.productionYear,
      location: entity.location != null
          ? LocationDetailModel.fromEntity(entity.location!)
          : null,
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
      notes: entity.notes,
      templateName: entity.templateName,
    );
  }

  AssetTemplateEntity toEntity() {
    return AssetTemplateEntity(
      id: id,
      assetId: assetId,
      templateName: templateName,
      name: name,
      brand: brand?.toEntity(),
      category: category?.toEntity(),
      price: price,
      productionYear: productionYear,
      location: location?.toEntity(),
      status: status,
      vendor: vendor,
      purchaseYear: purchaseYear,
      warrantyEndYear: warrantyEndYear,
      serviceSchedules: serviceSchedules?.map((e) => e.toEntity()).toList(),
      assetParent: assetParent?.toEntity(),
      notes: notes,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'template_name': templateName,
      'asset_id': assetId,
      'name': name,
      'brand_id': brand?.id,
      'category_id': category?.id,
      'price': price,
      'production_year': productionYear,
      'location_id': location?.id,
      'status': status,
      'vendor': vendor,
      'purchase_year': purchaseYear,
      'warranty_end_year': warrantyEndYear,
      'service_schedules': serviceSchedules?.map((x) => x.toMap()).toList(),
      'parent_id': assetParent?.id,
      'notes': notes,
    };
  }

  factory AssetTemplateModel.fromMap(Map<String, dynamic> map) {
    return AssetTemplateModel(
      id: map['id'] as String,
      templateName: map['template_name'] as String,
      assetId: map['asset_id'] as String,
      name: map['name'] != null ? map['name'] as String : null,
      brand: map['brand'] != null
          ? BrandDetailModel.fromMap(map['brand'])
          : null,
      category: map['category'] != null
          ? CategoryDetailModel.fromMap(map['category'])
          : null,
      price: map['price'] != null ? map['price'] as int : null,
      productionYear: map['production_year'] != null
          ? map['production_year'] as int
          : null,
      location: map['location'] != null
          ? LocationDetailModel.fromMap(map['location'])
          : null,
      status: map['status'] != null ? map['status'] as String : null,
      vendor: map['vendor'] != null ? map['vendor'] as String : null,
      purchaseYear: map['purchase_year'] != null
          ? map['purchase_year'] as int
          : null,
      warrantyEndYear: map['warranty_end_year'] != null
          ? map['warranty_end_year'] as int
          : null,
      serviceSchedules: map['service_schedules'] != null
          ? List.from(
              (map['service_schedules'] as List).map(
                (x) => ServiceScheduleModel.fromMap(x),
              ),
            )
          : null,
      assetParent: map['asset_parent'] != null
          ? AssetRefModel.fromMap(map['asset_parent'])
          : null,
      notes: map['notes'] != null ? map['notes'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AssetTemplateModel.fromJson(String source) =>
      AssetTemplateModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
