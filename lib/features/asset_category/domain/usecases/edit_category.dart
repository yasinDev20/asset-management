import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/asset_category/domain/entities/edit_category_entity.dart';
import 'package:assetmanagement/features/asset_category/domain/repositories/repo.dart';
import 'package:dartz/dartz.dart';

class EditCategoryUsecase {
  late final CategoryRepo _categoryRepo;

  EditCategoryUsecase({required CategoryRepo categoryRepo}) {
    _categoryRepo = categoryRepo;
  }

  Future<Either<Failure, Unit>> call({required EditCategoryEntity category}) async {
    return await _categoryRepo.editCategory(category: category);
  }
}
