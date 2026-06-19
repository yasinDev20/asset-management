import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/asset_location/domain/entities/location_detail_entity.dart';
import 'package:assetmanagement/features/asset_location/domain/repositories/repo.dart';
import 'package:dartz/dartz.dart';

class SearchLocationsUsecase {
  late final LocationRepo _locationRepo;

  SearchLocationsUsecase({required LocationRepo locationRepo}) {
    _locationRepo = locationRepo;
  }

  Future<Either<Failure, List<LocationDetailEntity>>> call({
    required String value,
  }) async {
    return await _locationRepo.searchLocations(value: value);
  }
}
