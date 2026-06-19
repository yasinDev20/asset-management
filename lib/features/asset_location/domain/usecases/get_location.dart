import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/asset_location/domain/entities/location_detail_entity.dart';
import 'package:assetmanagement/features/asset_location/domain/repositories/repo.dart';
import 'package:dartz/dartz.dart';

class GetLocationUsecase {
  late final LocationRepo _locationRepo;

  GetLocationUsecase({required LocationRepo locationRepo}) {
    _locationRepo = locationRepo;
  }

  Future<Either<Failure, LocationDetailEntity>> call({required String id}) async {
    return await _locationRepo.getLocation(id: id);
  }
}
