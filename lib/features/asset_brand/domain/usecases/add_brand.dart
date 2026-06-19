import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/asset_brand/domain/entities/add_brand_entity.dart';
import 'package:assetmanagement/features/asset_brand/domain/repositories/repo.dart';
import 'package:dartz/dartz.dart';

class AddBrandUsecase {
  late final BrandRepo _brandRepo;

  AddBrandUsecase({required BrandRepo brandRepo}) {
    _brandRepo = brandRepo;
  }

  Future<Either<Failure, Unit>> call({required AddBrandEntity brand}) async {
    return await _brandRepo.addBrand(brand: brand);
  }
}
