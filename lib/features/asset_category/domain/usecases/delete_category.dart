import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/asset_category/domain/repositories/repo.dart';
import 'package:dartz/dartz.dart';

class DeleteCategoryUsecase {
  final CategoryRepo _categoryRepo;

  DeleteCategoryUsecase({required CategoryRepo categoryRepo})
    : _categoryRepo = categoryRepo;

  Future<Either<Failure, Unit>> call({required String id}) async {
    // delete only if no asset has this category
    final hasAssetResult = await _categoryRepo.hasAsset(id: id);

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
      return await _categoryRepo.deleteCategory(id: id);
    }

    return Left(
      ServerFailure(
        message:
            'Kategori tidak bisa dihapus karena ada Asset yang menggunakannya',
      ),
    );
  }
}
