import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/asset_brand/domain/entities/brand_detail_entity.dart';
import 'package:assetmanagement/features/asset_brand/domain/repositories/repo.dart';
import 'package:dartz/dartz.dart';

class AddRecentBrandSelectionUsecase {
  late final BrandRepo _brandRepo;

  AddRecentBrandSelectionUsecase({required BrandRepo brandRepo}) {
    _brandRepo = brandRepo;
  }

  Future<Either<Failure, Unit>> call({required BrandDetailEntity brand}) async {
    return await _brandRepo.addRecentBrandSelection(brand: brand);
  }
}
