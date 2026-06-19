import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/core/utils/run_catching.dart';
import 'package:assetmanagement/features/asset_category/data/datasources/local_datasorce.dart';
import 'package:assetmanagement/features/asset_category/data/datasources/remote_datasource.dart';
import 'package:assetmanagement/features/asset_category/data/models/add_category_model.dart';
import 'package:assetmanagement/features/asset_category/data/models/category_detail_model.dart';
import 'package:assetmanagement/features/asset_category/data/models/edit_category_model.dart';
import 'package:assetmanagement/features/asset_category/domain/entities/add_category_entity.dart';
import 'package:assetmanagement/features/asset_category/domain/entities/category_detail_entity.dart';
import 'package:assetmanagement/features/asset_category/domain/entities/edit_category_entity.dart';
import 'package:assetmanagement/features/asset_category/domain/repositories/repo.dart';
import 'package:dartz/dartz.dart';

class CategoryRepoImpl extends CategoryRepo {
  final CategoryRemoteDatasource _categoryRemoteDatasource;
  final CategoryLocalDatasource _categoryLocalDatasource;

  CategoryRepoImpl({
    required CategoryRemoteDatasource remoteDatasource,
    required CategoryLocalDatasource localDatasource,
  }) : _categoryRemoteDatasource = remoteDatasource,
       _categoryLocalDatasource = localDatasource;

  @override
  Future<Either<Failure, List<CategoryDetailEntity>>> searchCategories({
    required String value,
  }) async {
    return await runCatching(() async {
      final result = await _categoryRemoteDatasource.searchCategories(
        value: value,
      );
      return result.map((e) => e.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, CategoryDetailEntity>> getCategory({
    required String id,
  }) async {
    return await runCatching(() async {
      final result = await _categoryRemoteDatasource.getCategory(id: id);
      return result.toEntity();
    });
  }

  @override
  Future<Either<Failure, Unit>> addCategory({
    required AddCategoryEntity category,
  }) async {
    return await runCatching(() async {
      await _categoryRemoteDatasource.addCategory(
        category: AddCategoryModel.fromEntity(category),
      );
      return unit;
    });
  }

  @override
  Future<Either<Failure, Unit>> editCategory({
    required EditCategoryEntity category,
  }) async {
    return await runCatching(() async {
      await _categoryRemoteDatasource.editCategory(
        category: EditCategoryModel.fromEntity(category),
      );
      return unit;
    });
  }

  @override
  Future<Either<Failure, bool>> hasAsset({required String id}) async {
    return await runCatching(() async {
      final result = await _categoryRemoteDatasource.hasAsset(id: id);
      return result;
    });
  }

  @override
  Future<Either<Failure, Unit>> deleteCategory({required String id}) async {
    return await runCatching(() async {
      await _categoryRemoteDatasource.deleteCategory(id: id);
      return unit;
    });
  }

  @override
  Future<Either<Failure, Unit>> addRecentCategorySelection({
    required CategoryDetailEntity category,
  }) async {
    return await runCatching(() async {
      await _categoryLocalDatasource.addRecentCategorySelections(
        CategoryDetailModel.fromEntity(category),
      );
      return unit;
    });
  }

  @override
  Future<Either<Failure, List<CategoryDetailEntity>>>
  getRecentCategorySelections() async {
    return await runCatching(() async {
      final result = await _categoryLocalDatasource
          .getRecentCategorySelections();
      return result.map((e) => e.toEntity()).toList();
    });
  }
}
