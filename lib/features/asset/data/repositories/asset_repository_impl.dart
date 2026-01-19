import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/core/utils/run_catching.dart';
import 'package:assetmanagement/features/asset/data/datasources/remote_datasource.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_summary_entity.dart';
import 'package:assetmanagement/features/asset/domain/repositories/asset_repository.dart';
import 'package:dartz/dartz.dart';

class AssetRepositoryImpl extends AssetRepository {
  final AssetRemoteDataSource _assetRemoteDataSource;

  AssetRepositoryImpl(this._assetRemoteDataSource);
  @override
  Future<Either<Failure, List<AssetSummaryEntity>>> getAssets(
    List<Map<String,String>> filter,
  ) async {
    return runCatching(() async {
      final result = await _assetRemoteDataSource.getAssets(filter);

      return result.map((e) => e.toEntity()).toList();
    });
  }
}
