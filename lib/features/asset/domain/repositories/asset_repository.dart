import 'dart:io';

import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_detail_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_filter_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_lite_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_ref_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_template_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/add_asset_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/edit_asset_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AssetRepository {
  Future<Either<Failure, AssetDetailEntity>> getAssetDetail(String id);
  Future<Either<Failure, Unit>> addAsset(AddAssetEntity addAssetEntity);
  Future<Either<Failure, Unit>> editAsset({
    required EditAssetEntity originalAssetEntity,
    required EditAssetEntity editAssetEntity,
  });

  Future<Either<Failure, Unit>> addToTemplate(
    AssetTemplateEntity assetTemplateEntity,
  );
  Future<Either<Failure, Unit>> deleteTemplate(String id);
  Future<Either<Failure, List<AssetTemplateEntity>>> getTemplate(String search);

  Future<Either<Failure, String>> getUrl(String path);
  Future<Either<Failure, List<AssetLiteEntity>>> getAssetsLite(
    AssetFilterEntity? filter, {
    required int page,
    required int pageSize,
  });

  Future<Either<Failure, String>> uploadImage(File fileData, String assetId);
  Future<Either<Failure, List<AssetRefEntity>>> getAssetRefs({
    String? assetId,
    String? qrCode,
  });
  Future<Either<Failure, String>> downloadFile({
    required String url,
    required String fileName,
    void Function(double progress)? onProgress,
  });
}
