import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_lite_entity.dart';
import 'package:assetmanagement/features/asset/domain/repositories/asset_repository.dart';
import 'package:dartz/dartz.dart';

class GetAssetsLiteUsecase {
  final AssetRepository _assetRepository;

  GetAssetsLiteUsecase(this._assetRepository);

  Future<Either<Failure, List<AssetLiteEntity>>> call(List<Map<String,String>> filter) async {
    return await _assetRepository.getAssetsLite(filter);

    
  }
  
}
