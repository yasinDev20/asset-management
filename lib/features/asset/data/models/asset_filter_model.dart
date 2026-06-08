import 'package:assetmanagement/features/asset/domain/entities/asset_filter_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/brand_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/category_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/location_entity.dart';
import 'package:equatable/equatable.dart';

class AssetFilterModel extends Equatable {
  final List<LocationEntity> locations;
  final List<CategoryEntity> categories;
  final List<BrandEntity> brands;
  final List<String> vendor;
  final List<String> status;
  final String? qrCode;
  final List<int> productionYear;
  final List<int> purchaseYear;
  final List<int> warrantyEndYear;

  const AssetFilterModel({
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

  AssetFilterEntity toEntity() {
    return AssetFilterEntity(
      locations: locations,
      categories: categories,
      brands: brands,
      vendor: vendor,
      status: status,
      qrCode: qrCode,
      productionYear: productionYear,
      purchaseYear: purchaseYear,
      warrantyEndYear: warrantyEndYear,
    );
  }

  factory AssetFilterModel.fromEntity(AssetFilterEntity entity) {
    return AssetFilterModel(
      locations: entity.locations,
      categories: entity.categories,
      brands: entity.brands,
      vendor: entity.vendor,
      status: entity.status,
      qrCode: entity.qrCode,
      productionYear: entity.productionYear,
      purchaseYear: entity.purchaseYear,
      warrantyEndYear: entity.warrantyEndYear,
    );
  }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'locationIds': locations.map(toElement),
  //     'categoriIds': categories,
  //     'brandIds': brands,
  //     'vendor': vendor,
  //     'status': status,
  //     'productionYear': productionYear,
  //     'purchaseYear': purchaseYear,
  //     'warrantyEndYear': warrantyEndYear,
  //   };
  // }

  // factory AssetFilterModel.fromMap(Map<String, dynamic> map) {
  //   return AssetFilterModel(
  //     locationIds: List<String>.from((map['locationIds'] as List<String>)),
  //     categoriIds: List<String>.from((map['categoriIds'] as List<String>)),
  //     brandIds: List<String>.from((map['brandIds'] as List<String>)),
  //     vendor: List<String>.from((map['vendor'] as List<String>)),
  //     status: List<String>.from((map['status'] as List<String>)),
  //     productionYear: map['productionYear'] as String,
  //     purchaseYear: map['purchaseYear'] as String,
  //     warrantyEndYear: map['warrantyEndYear'] as String,
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory AssetFilterModel.fromJson(String source) =>
  //     AssetFilterModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
