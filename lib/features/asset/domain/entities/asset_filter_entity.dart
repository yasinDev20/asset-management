// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:assetmanagement/features/asset_brand/domain/entities/brand_detail_entity.dart';
import 'package:assetmanagement/features/asset_category/domain/entities/category_detail_entity.dart';
import 'package:assetmanagement/features/asset_location/domain/entities/location_detail_entity.dart';

class AssetFilterEntity extends Equatable {
  final List<LocationDetailEntity> locations;
  final List<CategoryDetailEntity> categories;
  final List<BrandDetailEntity> brands;
  final List<String> vendor;
  final List<String> status;
  final String? qrCode;
  final List<int> productionYear;
  final List<int> purchaseYear;
  final List<int> warrantyEndYear;

  const AssetFilterEntity({
    this.locations = const [],
    this.categories = const [],
    this.brands = const [],
    this.vendor = const [],
    this.status = const [],
    this.qrCode,
    this.productionYear = const [],
    this.purchaseYear = const [],
    this.warrantyEndYear = const [],
  });

  @override
  List<Object> get props {
    return [
      locations,
      categories,
      brands,
      vendor,
      status,
      ?qrCode,
      productionYear,
      purchaseYear,
      warrantyEndYear,
    ];
  }

  AssetFilterEntity copyWith({
    List<LocationDetailEntity>? locations,
    List<CategoryDetailEntity>? categories,
    List<BrandDetailEntity>? brands,
    List<String>? vendor,
    List<String>? status,
    String? qrCode,
    List<int>? productionYear,
    List<int>? purchaseYear,
    List<int>? warrantyEndYear,
  }) {
    return AssetFilterEntity(
      locations: locations ?? this.locations,
      categories: categories ?? this.categories,
      brands: brands ?? this.brands,
      vendor: vendor ?? this.vendor,
      status: status ?? this.status,
      qrCode: qrCode ?? this.qrCode,
      productionYear: productionYear ?? this.productionYear,
      purchaseYear: purchaseYear ?? this.purchaseYear,
      warrantyEndYear: warrantyEndYear ?? this.warrantyEndYear,
    );
  }
}
