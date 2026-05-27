import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/asset/domain/entities/edit_asset_entity.dart';
import 'package:assetmanagement/features/asset/domain/repositories/asset_repository.dart';
import 'package:dartz/dartz.dart';

class EditAssetUsecase {
  final AssetRepository _assetRepository;

  EditAssetUsecase(this._assetRepository);

  Future<Either<Failure, Unit>> call({
    required EditAssetEntity originalAssetEntity,
    required EditAssetEntity editAssetEntity,
  }) async {
    return await _assetRepository.editAsset(
      originalAssetEntity: originalAssetEntity,
      editAssetEntity: editAssetEntity,
    );
  }
}
