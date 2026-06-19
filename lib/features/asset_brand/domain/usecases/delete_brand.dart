import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/asset_brand/domain/repositories/repo.dart';
import 'package:dartz/dartz.dart';

class DeleteBrandUsecase {
  late final BrandRepo _brandRepo;

  DeleteBrandUsecase({required BrandRepo brandRepo}) {
    _brandRepo = brandRepo;
  }

  Future<Either<Failure, Unit>> call({required String id}) async {
   // delete only if no asset has this category
    final hasAssetResult = await _brandRepo.hasAsset(id: id);

    if (hasAssetResult.isLeft()) {
      return Left(
        hasAssetResult.swap().getOrElse(
          () => throw StateError('Expected Left<bool>'),
        ),
      );
    }

    final hasAsset = hasAssetResult.getOrElse(
      () => throw StateError('Expected Right<bool>'),
    );

    if (!hasAsset) {
      return await _brandRepo.deleteBrand(id: id);
    }

    return Left(
      ServerFailure(
        message:
            'Merek tidak bisa dihapus karena ada Asset yang menggunakannya',
      ),
    );
  }
}
