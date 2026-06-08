import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_filter_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_lite_entity.dart';
import 'package:assetmanagement/features/asset/domain/repositories/asset_repository.dart';
import 'package:dartz/dartz.dart';

class GetAssetsLiteUsecase {
  final AssetRepository _assetRepository;

  GetAssetsLiteUsecase(this._assetRepository);

  Future<Either<Failure, List<AssetLiteEntity>>> call(
    AssetFilterEntity? filter, {
    required int page,
    required int pageSize,
  }) async {
    return await _assetRepository.getAssetsLite(filter, page: page, pageSize: pageSize);
  }
}
