import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/core/utils/run_catching.dart';
import 'package:assetmanagement/features/asset_brand/data/datasources/local_datasource.dart';
import 'package:assetmanagement/features/asset_brand/data/datasources/remote_datasource.dart';
import 'package:assetmanagement/features/asset_brand/data/models/add_brand_model.dart';
import 'package:assetmanagement/features/asset_brand/data/models/brand_detail_model.dart';
import 'package:assetmanagement/features/asset_brand/data/models/edit_brand_model.dart';
import 'package:assetmanagement/features/asset_brand/domain/entities/add_brand_entity.dart';
import 'package:assetmanagement/features/asset_brand/domain/entities/brand_detail_entity.dart';
import 'package:assetmanagement/features/asset_brand/domain/entities/edit_brand_entity.dart';
import 'package:assetmanagement/features/asset_brand/domain/repositories/repo.dart';
import 'package:dartz/dartz.dart';

class BrandRepoImpl extends BrandRepo {
  final BrandRemoteDatasource _remoteDatasource;
  final BrandLocalDatasource _localDatasource;
  BrandRepoImpl({
    required BrandRemoteDatasource remoteDatasource,
    required BrandLocalDatasource localDatasource,
  }) : _remoteDatasource = remoteDatasource,
       _localDatasource = localDatasource;

  @override
  Future<Either<Failure, List<BrandDetailEntity>>> searchBrands({
    required String value,
  }) async {
    return await runCatching(() async {
      final result = await _remoteDatasource.searchBrands(value: value);
      return result.map((e) => e.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, BrandDetailEntity>> getBrand({
    required String id,
  }) async {
    return await runCatching(() async {
      final result = await _remoteDatasource.getBrand(id: id);

      return result.toEntity();
    });
  }

  @override
  Future<Either<Failure, Unit>> addBrand({
    required AddBrandEntity brand,
  }) async {
    return await runCatching(() async {
      await _remoteDatasource.addBrand(brand: AddBrandModel.fromEntity(brand));
      return unit;
    });
  }

  @override
  Future<Either<Failure, Unit>> editBrand({
    required EditBrandEntity brand,
  }) async {
    return await runCatching(() async {
      await _remoteDatasource.editBrand(
        brand: EditBrandModel.fromEntity(brand),
      );
      return unit;
    });
  }

  @override
  Future<Either<Failure, bool>> hasAsset({required String id}) async {
    return await runCatching(() async {
      return await _remoteDatasource.hasAsset(id: id);
    });
  }

  @override
  Future<Either<Failure, Unit>> deleteBrand({required String id}) async {
    return await runCatching(() async {
      await _remoteDatasource.deleteBrand(id: id);
      return unit;
    });
  }

  @override
  Future<Either<Failure, Unit>> addRecentBrandSelection({
    required BrandDetailEntity brand,
  }) async {
    return await runCatching(() async {
      await _localDatasource.addRecentBrandSelection(
        BrandDetailModel.fromEntity(brand),
      );
      return unit;
    });
  }

  @override
  Future<Either<Failure, List<BrandDetailEntity>>>
  getRecentBrandSelections() async {
    return await runCatching(() async {
      final result = await _localDatasource.getRecentBrandSelections();
      return result.map((e) => e.toEntity()).toList();
    });
  }
}
