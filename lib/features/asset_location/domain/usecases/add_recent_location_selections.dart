import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/asset_location/domain/entities/location_detail_entity.dart';
import 'package:assetmanagement/features/asset_location/domain/repositories/repo.dart';
import 'package:dartz/dartz.dart';

class AddRecentLocationSelectionUsecase {
  late final LocationRepo _locationRepo;

  AddRecentLocationSelectionUsecase({required LocationRepo locationRepo}) {
    _locationRepo = locationRepo;
  }

  Future<Either<Failure, Unit>> call({required LocationDetailEntity location}) async {
    return await _locationRepo.addRecentLocationSelection(location: location);
  }
}
