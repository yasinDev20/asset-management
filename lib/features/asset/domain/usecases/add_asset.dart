import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/asset/domain/entities/add_asset_entity.dart';
import 'package:assetmanagement/features/asset/domain/repositories/asset_repository.dart';
import 'package:dartz/dartz.dart';

class AddAssetUsecase {
  final AssetRepository _assetRepository;

  AddAssetUsecase(this._assetRepository);

  Future<Either<Failure, Unit>> call(AddAssetEntity addAssetEntity) async {
    return await _assetRepository.addAsset(addAssetEntity);
  }
  
}