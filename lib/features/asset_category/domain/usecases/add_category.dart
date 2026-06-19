import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/asset_category/domain/entities/add_category_entity.dart';
import 'package:assetmanagement/features/asset_category/domain/repositories/repo.dart';
import 'package:dartz/dartz.dart';

class AddCategoryUsecase {
  late final CategoryRepo _categoryRepo;

  AddCategoryUsecase({required CategoryRepo categoryRepo}) {
    _categoryRepo = categoryRepo;
  }

  Future<Either<Failure, Unit>> call({required AddCategoryEntity category}) async {
    return await _categoryRepo.addCategory(category: category);
  }
}
