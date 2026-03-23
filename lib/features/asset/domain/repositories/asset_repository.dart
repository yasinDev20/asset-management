import 'dart:io';

import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_detail_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_lite_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_ref_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/brand_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/category_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/location_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AssetRepository {
  Future<Either<Failure, String>> getUrl(String path);
  Future<Either<Failure, String>> uploadImage(File fileData, String assetId);
  Future<Either<Failure, List<AssetLiteEntity>>> getAssetsLite(
    List<Map<String, String>> filter,
  );

  Future<Either<Failure, AssetDetailEntity>> getAssetDetail(String id);
  Future<Either<Failure, List<AssetRefEntity>>> getAssetRefs({
    List<String>? ids,
    List<String>? qrCodes,
  });
  Future<Either<Failure, List<BrandEntity>>> getBrands(String value);
  Future<Either<Failure, Unit>> addBrand({
    required String name,
    required String ownerId,
  });
  Future<Either<Failure, List<CategoryEntity>>> getCategories(String value);
  Future<Either<Failure, Unit>> addCategory({
    required String ownerId,
    required String name,
    required String code,
  });
  Future<Either<Failure, List<LocationEntity>>> getLocations(String value);
  Future<Either<Failure, Unit>> addLocation({
    required String ownerId,
    required String name,
  });

  //Local data source
  Future<Either<Failure, List<BrandEntity>>> getRecentBrandSelections();
  Future<Either<Failure, Unit>> addRecentBrandSelection(BrandEntity recentBrandSelection);
  Future<Either<Failure, List<CategoryEntity>>> getRecentCategorySelections();
  Future<Either<Failure, Unit>> addRecentCategorySelection(CategoryEntity recentCategorySelection);
  Future<Either<Failure, List<LocationEntity>>> getRecentLocationSelections();
  Future<Either<Failure, Unit>> addRecentLocationSelection(LocationEntity recentLocationSelection);
}
