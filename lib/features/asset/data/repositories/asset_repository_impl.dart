import 'dart:io';

import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/core/utils/run_catching.dart';
import 'package:assetmanagement/features/asset/data/datasources/local_datasource.dart';
import 'package:assetmanagement/features/asset/data/datasources/remote_datasource.dart';
import 'package:assetmanagement/features/asset/data/models/add_asset_model.dart';
import 'package:assetmanagement/features/asset/data/models/asset_filter_model.dart';
import 'package:assetmanagement/features/asset/data/models/asset_template_model.dart';
import 'package:assetmanagement/features/asset/data/models/brand_model.dart';
import 'package:assetmanagement/features/asset/data/models/category_model.dart';
import 'package:assetmanagement/features/asset/data/models/edit_asset_model.dart';
import 'package:assetmanagement/features/asset/data/models/location_model.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_detail_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_filter_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_lite_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_ref_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_template_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/brand_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/category_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/add_asset_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/edit_asset_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/location_entity.dart';
import 'package:assetmanagement/features/asset/domain/repositories/asset_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AssetRepositoryImpl extends AssetRepository {
  final AssetRemoteDataSource _assetRemoteDataSource;
  final AssetLocalDataSource _assetLocalDataSource;

  AssetRepositoryImpl({
    required AssetRemoteDataSource assetRemoteDataSource,
    required SupabaseClient supabaseClient,
    required AssetLocalDataSource assetLocalDatasource,
  }) : _assetRemoteDataSource = assetRemoteDataSource,
       _assetLocalDataSource = assetLocalDatasource;

  @override
  Future<Either<Failure, List<AssetLiteEntity>>> getAssetsLite(
    AssetFilterEntity? filter, {
    required int page,
    required int pageSize,
  }) async {
    return await runCatching(() async {
      final filterModel = filter != null
          ? AssetFilterModel.fromEntity(filter)
          : null;
      final result = await _assetRemoteDataSource.getAssetsLite(
        filterModel,
        page: page,
        pageSize: pageSize,
      );
      //convert image path to image url
      final assets = await Future.wait(
        result.map((assetModel) async {
          final imageUrl = await _assetRemoteDataSource.getUrlFile(
            assetModel.image,
          );
          return assetModel.toEntity(imageUrl: imageUrl);
        }).toList(),
      );

      return assets;
    });
  }

  @override
  Future<Either<Failure, AssetDetailEntity>> getAssetDetail(String id) async {
    return await runCatching(() async {
      final result = await _assetRemoteDataSource.getAssetDetail(id);

      final assetChildData = await _assetRemoteDataSource.getAssetRefs(
        assetId: result.id,
      );

      return result.toEntity(
        assetChildData: assetChildData.map((e) => e.toEntity()).toList(),
      );
    });
  }

  @override
  Future<Either<Failure, List<AssetRefEntity>>> getAssetRefs({
    String? assetId,
    String? qrCode,
  }) async {
    return await runCatching(() async {
      final result = await _assetRemoteDataSource.getAssetRefs(
        assetId: assetId,
        qrCodes: qrCode,
      );

      return result.map((e) => e.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, String>> getUrl(String path) async {
    return await runCatching(() async {
      return await _assetRemoteDataSource.getUrlFile(path);
    });
  }

  @override
  Future<Either<Failure, String>> uploadImage(File fileData, String assetId) {
    // TODO: implement uploadImage
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<BrandEntity>>> getBrands(String value) async {
    return await runCatching(() async {
      final result = await _assetRemoteDataSource.getBrands(value);
      return result.map((e) => e.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, Unit>> addBrand({
    required String name,
    required String ownerId,
  }) async {
    return await runCatching(() async {
      await _assetRemoteDataSource.addBrand(name: name, ownerId: ownerId);
      return unit;
    });
  }

  @override
  Future<Either<Failure, Unit>> addCategory({
    required String ownerId,
    required String name,
    required String code,
  }) async {
    return await runCatching(() async {
      await _assetRemoteDataSource.addCategory(
        name: name,
        code: code,
        ownerId: ownerId,
      );
      return unit;
    });
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories(
    String value,
  ) async {
    return await runCatching(() async {
      final result = await _assetRemoteDataSource.getCategories(value);
      return result.map((e) => e.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, Unit>> addLocation({
    required String ownerId,
    required String name,
  }) async {
    return await runCatching(() async {
      await _assetRemoteDataSource.addLocation(name: name, ownerId: ownerId);
      return unit;
    });
  }

  @override
  Future<Either<Failure, List<LocationEntity>>> getLocations(
    String value,
  ) async {
    return await runCatching(() async {
      final result = await _assetRemoteDataSource.getLocations(value);
      return result.map((e) => e.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, Unit>> addRecentBrandSelection(
    BrandEntity recentBrandSelection,
  ) async {
    return await runCatching(() async {
      await _assetLocalDataSource.addRecentBrandSelections(
        BrandModel.fromEntity(recentBrandSelection),
      );
      return unit;
    });
  }

  @override
  Future<Either<Failure, List<BrandEntity>>> getRecentBrandSelections() async {
    return await runCatching(() async {
      final result = await _assetLocalDataSource.getRecentBrandSelections();
      return result.map((e) => e.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, Unit>> addRecentCategorySelection(
    CategoryEntity recentCategorySelection,
  ) async {
    return await runCatching(() async {
      await _assetLocalDataSource.addRecentCategorySelections(
        CategoryModel.fromEntity(recentCategorySelection),
      );
      return unit;
    });
  }

  @override
  Future<Either<Failure, List<CategoryEntity>>>
  getRecentCategorySelections() async {
    return await runCatching(() async {
      final result = await _assetLocalDataSource.getRecentCategorySelections();
      return result.map((e) => e.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, Unit>> addRecentLocationSelection(
    LocationEntity recentLocationSelection,
  ) async {
    return await runCatching(() async {
      await _assetLocalDataSource.addRecentLocationSelections(
        LocationModel.fromEntity(recentLocationSelection),
      );
      return unit;
    });
  }

  @override
  Future<Either<Failure, List<LocationEntity>>>
  getRecentLocationSelections() async {
    return await runCatching(() async {
      final result = await _assetLocalDataSource.getRecentLocationSelections();
      return result.map((e) => e.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, Unit>> addAsset(AddAssetEntity addAssetEntity) async {
    return await runCatching(() async {
      final addAssetModel = AddAssetModel.fromEntity(addAssetEntity);
      await _assetRemoteDataSource.addAsset(addAssetModel);
      return unit;
    });
  }

  @override
  Future<Either<Failure, String>> downloadFile({
    required String url,
    required String fileName,
    void Function(double progress)? onProgress,
  }) async {
    return await runCatching(() async {
      final path = await _assetRemoteDataSource.downloadFile(
        url: url,
        fileName: fileName,
      );
      return path;
    });
  }

  @override
  Future<Either<Failure, Unit>> editAsset({
    required EditAssetEntity originalAssetEntity,
    required EditAssetEntity editAssetEntity,
  }) async {
    return await runCatching(() async {
      final originalAssetModel = EditAssetModel.fromEntity(originalAssetEntity);
      final editAssetModel = EditAssetModel.fromEntity(editAssetEntity);
      await _assetRemoteDataSource.editAsset(
        originalAssetModel: originalAssetModel,
        editAssetModel: editAssetModel,
      );
      return unit;
    });
  }

  @override
  Future<Either<Failure, Unit>> addToTemplate(
    AssetTemplateEntity assetTemplateEntity,
  ) async {
    return await runCatching(() async {
      final assetTemplateModel = AssetTemplateModel.fromEntity(
        assetTemplateEntity,
      );
      await _assetRemoteDataSource.addToTemplate(
        assetTemplateModel: assetTemplateModel,
      );
      return unit;
    });
  }

  @override
  Future<Either<Failure, List<AssetTemplateEntity>>> getTemplate(
    String search,
  ) async {
    return await runCatching(() async {
      final result = await _assetRemoteDataSource.getTemplate(search: search);
      return result.map((e) => e.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, Unit>> deleteTemplate(String id) async {
    return await runCatching(() async {
      await _assetRemoteDataSource.deleteTemplate(id);
      return unit;
    });
  }
}
