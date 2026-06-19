import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/asset_brand/domain/entities/brand_detail_entity.dart';
import 'package:assetmanagement/features/asset_brand/domain/repositories/repo.dart';
import 'package:dartz/dartz.dart';

class GetBrandUsecase {
  late final BrandRepo _brandRepo;

  GetBrandUsecase({required BrandRepo brandRepo}) {
    _brandRepo = brandRepo;
  }

  Future<Either<Failure, BrandDetailEntity>> call({required String id}) async {
    return await _brandRepo.getBrand(id: id);
  }
}
