import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_summary_entity.dart';
import 'package:assetmanagement/features/asset/domain/repositories/asset_repository.dart';
import 'package:dartz/dartz.dart';

class GetAssetsUsecase {
  final AssetRepository _assetRepository;

  GetAssetsUsecase(this._assetRepository);

  Future<Either<Failure, List<AssetSummaryEntity>>> call(List<Map<String,String>> filter) async {
    return await _assetRepository.getAssets(filter);
  }
  
}
