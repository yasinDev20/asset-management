import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/asset_location/domain/entities/add_location_entity%20.dart';
import 'package:assetmanagement/features/asset_location/domain/entities/edit_location_entity.dart';
import 'package:assetmanagement/features/asset_location/domain/entities/location_detail_entity.dart';
import 'package:dartz/dartz.dart';

abstract class LocationRepo{
  Future<Either<Failure, List<LocationDetailEntity>>> searchLocations({
    required String value,
  });
  Future<Either<Failure, LocationDetailEntity>> getLocation({required String id});
  Future<Either<Failure, Unit>> addLocation({required AddLocationEntity location});
  Future<Either<Failure, Unit>> editLocation({required EditLocationEntity location});
  Future<Either<Failure, bool>> hasAsset({required String id});
  Future<Either<Failure, Unit>> deleteLocation({required String id});
  Future<Either<Failure, List<LocationDetailEntity>>> getRecentLocationSelections();
  Future<Either<Failure, Unit>> addRecentLocationSelection({
    required LocationDetailEntity location
  });

}