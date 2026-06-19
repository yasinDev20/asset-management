import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/asset_location/domain/entities/add_location_entity%20.dart';
import 'package:assetmanagement/features/asset_location/domain/repositories/repo.dart';
import 'package:dartz/dartz.dart';

class AddLocationUsecase {
  late final LocationRepo _locationRepo;

  AddLocationUsecase({required LocationRepo locationRepo}) {
    _locationRepo = locationRepo;
  }

  Future<Either<Failure, Unit>> call({required AddLocationEntity location}) async {
    return await _locationRepo.addLocation(location: location);
  }
}
