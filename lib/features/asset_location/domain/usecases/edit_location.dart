import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/asset_location/domain/entities/edit_location_entity.dart';
import 'package:assetmanagement/features/asset_location/domain/repositories/repo.dart';
import 'package:dartz/dartz.dart';

class EditLocationUsecase {
  late final LocationRepo _locationRepo;

  EditLocationUsecase({required LocationRepo locationRepo}) {
    _locationRepo = locationRepo;
  }

  Future<Either<Failure, Unit>> call({required EditLocationEntity location}) async {
    return await _locationRepo.editLocation(location: location);
  }
}
