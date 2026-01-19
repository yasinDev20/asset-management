import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_summary_entity.dart';
import 'package:dartz/dartz.dart';

abstract class AssetRepository {
  Future<Either<Failure, List<AssetSummaryEntity>>> getAssets(List<Map<String,String>> filter);
}