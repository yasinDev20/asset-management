// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:assetmanagement/features/asset/domain/entities/brand_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/category_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/location_entity.dart';

class AssetFilterEntity extends Equatable {
  final List<LocationEntity> locations;
  final List<CategoryEntity> categories;
  final List<BrandEntity> brands;
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
    List<LocationEntity>? locations,
    List<CategoryEntity>? categories,
    List<BrandEntity>? brands,
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
