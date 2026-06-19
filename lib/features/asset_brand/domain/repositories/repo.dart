import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/asset_brand/domain/entities/add_brand_entity.dart';
import 'package:assetmanagement/features/asset_brand/domain/entities/brand_detail_entity.dart';
import 'package:assetmanagement/features/asset_brand/domain/entities/edit_brand_entity.dart';
import 'package:dartz/dartz.dart';

abstract class BrandRepo {
  Future<Either<Failure, List<BrandDetailEntity>>> searchBrands({
    required String value,
  });
  Future<Either<Failure, BrandDetailEntity>> getBrand({required String id});
  Future<Either<Failure, Unit>> addBrand({required AddBrandEntity brand});
  Future<Either<Failure, Unit>> editBrand({required EditBrandEntity brand});
  Future<Either<Failure, Unit>> deleteBrand({required String id});
  Future<Either<Failure, bool>> hasAsset({required String id});
  Future<Either<Failure, List<BrandDetailEntity>>> getRecentBrandSelections();
  Future<Either<Failure, Unit>> addRecentBrandSelection({
    required BrandDetailEntity brand
  });
}
