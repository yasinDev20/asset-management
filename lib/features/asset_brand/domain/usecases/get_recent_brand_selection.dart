import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/asset_brand/domain/entities/brand_detail_entity.dart';
import 'package:assetmanagement/features/asset_brand/domain/repositories/repo.dart';
import 'package:dartz/dartz.dart';

class GetRecentBrandSelectionsUsecase {
  late final BrandRepo _brandRepo;

  GetRecentBrandSelectionsUsecase({required BrandRepo brandRepo}) {
    _brandRepo = brandRepo;
  }

  Future<Either<Failure, List<BrandDetailEntity>>> call() async {
    return await _brandRepo.getRecentBrandSelections();
  }
}
