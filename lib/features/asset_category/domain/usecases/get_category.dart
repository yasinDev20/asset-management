import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/asset_category/domain/entities/category_detail_entity.dart';
import 'package:assetmanagement/features/asset_category/domain/repositories/repo.dart';
import 'package:dartz/dartz.dart';

class GetCategoryUsecase {
  late final CategoryRepo _categoryRepo;

  GetCategoryUsecase({required CategoryRepo categoryRepo}) {
    _categoryRepo = categoryRepo;
  }

  Future<Either<Failure, CategoryDetailEntity>> call({required String id}) async {
    return await _categoryRepo.getCategory(id: id);
  }
}
