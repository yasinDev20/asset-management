import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/asset_brand/domain/entities/edit_brand_entity.dart';
import 'package:assetmanagement/features/asset_brand/domain/repositories/repo.dart';
import 'package:dartz/dartz.dart';

class EditBrandUsecase {
  late final BrandRepo _brandRepo;

  EditBrandUsecase({required BrandRepo brandRepo}) {
    _brandRepo = brandRepo;
  }

  Future<Either<Failure, Unit>> call({required EditBrandEntity brand}) async {
    return await _brandRepo.editBrand(brand: brand);
  }
}
