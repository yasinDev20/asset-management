import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/asset_category/domain/entities/category_detail_entity.dart';
import 'package:assetmanagement/features/asset_category/domain/repositories/repo.dart';
import 'package:dartz/dartz.dart';

class AddRecentCategorySelectionUsecase {
  late final CategoryRepo _categoryRepo;

  AddRecentCategorySelectionUsecase({required CategoryRepo categoryRepo}) {
    _categoryRepo = categoryRepo;
  }

  Future<Either<Failure, Unit>> call({required CategoryDetailEntity category}) async {
    return await _categoryRepo.addRecentCategorySelection(category: category);
  }
}
