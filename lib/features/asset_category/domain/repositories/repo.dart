import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/asset_category/domain/entities/add_category_entity.dart';
import 'package:assetmanagement/features/asset_category/domain/entities/category_detail_entity.dart';
import 'package:assetmanagement/features/asset_category/domain/entities/edit_category_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CategoryRepo {
  Future<Either<Failure, List<CategoryDetailEntity>>> searchCategories({
    required String value,
  });
  Future<Either<Failure, CategoryDetailEntity>> getCategory({required String id});
  Future<Either<Failure, Unit>> addCategory({required AddCategoryEntity category});
  Future<Either<Failure, Unit>> editCategory({required EditCategoryEntity category});
  Future<Either<Failure, Unit>> deleteCategory({required String id});
  Future<Either<Failure, bool>> hasAsset({required String id});
  Future<Either<Failure, List<CategoryDetailEntity>>> getRecentCategorySelections();
  Future<Either<Failure, Unit>> addRecentCategorySelection({
    required CategoryDetailEntity category
  });
}
