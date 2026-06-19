import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/asset_category/domain/entities/category_detail_entity.dart';
import 'package:assetmanagement/features/asset_category/domain/repositories/repo.dart';
import 'package:dartz/dartz.dart';

class SearchCategoriesUsecase {
  late final CategoryRepo _categoryRepo;

  SearchCategoriesUsecase({required CategoryRepo categoryRepo}) {
    _categoryRepo = categoryRepo;
  }

 Future<Either<Failure, List<CategoryDetailEntity>>> call({required String value}) async{
    return await _categoryRepo.searchCategories(value: value);
  }
}
