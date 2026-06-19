import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/asset_location/domain/repositories/repo.dart';
import 'package:dartz/dartz.dart';

class DeleteLocationUsecase {
  late final LocationRepo _locationRepo;

  DeleteLocationUsecase({required LocationRepo locationRepo}) {
    _locationRepo = locationRepo;
  }

  Future<Either<Failure, Unit>> call({required String id}) async {
   // delete only if no asset has this category
    final hasAssetResult = await _locationRepo.hasAsset(id: id);

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
      return await _locationRepo.deleteLocation(id: id);
    }

    return Left(
      ServerFailure(
        message:
            'Lokasi tidak bisa dihapus karena ada Asset yang menggunakannya',
      ),
    );
  }
}
