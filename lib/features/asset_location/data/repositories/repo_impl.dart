import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/core/utils/run_catching.dart';
import 'package:assetmanagement/features/asset_location/data/datasources/local_datasource.dart';
import 'package:assetmanagement/features/asset_location/data/datasources/remote_datasource.dart';
import 'package:assetmanagement/features/asset_location/data/models/add_location_model.dart';
import 'package:assetmanagement/features/asset_location/data/models/edit_location_model.dart';
import 'package:assetmanagement/features/asset_location/data/models/location_detail_model.dart';
import 'package:assetmanagement/features/asset_location/domain/entities/add_location_entity%20.dart';
import 'package:assetmanagement/features/asset_location/domain/entities/edit_location_entity.dart';
import 'package:assetmanagement/features/asset_location/domain/entities/location_detail_entity.dart';
import 'package:assetmanagement/features/asset_location/domain/repositories/repo.dart';
import 'package:dartz/dartz.dart';

class LocationRepoImpl extends LocationRepo {
  final LocationRemoteDatasource _remoteDatasource;
  final LocationLocalDatasource _localDatasource;
  LocationRepoImpl({
    required LocationRemoteDatasource remoteDatasource,
    required LocationLocalDatasource localDatasource,
  }) : _remoteDatasource = remoteDatasource,
       _localDatasource = localDatasource;

  @override
  Future<Either<Failure, List<LocationDetailEntity>>> searchLocations({
    required String value,
  }) async {
    return await runCatching(() async {
      final result = await _remoteDatasource.searchLocations(value: value);
      return result.map((e) => e.toEntity()).toList();
    });
  }

  @override
  Future<Either<Failure, LocationDetailEntity>> getLocation({
    required String id,
  }) async {
    return await runCatching(() async {
      final result = await _remoteDatasource.getLocation(id: id);

      return result.toEntity();
    });
  }

  @override
  Future<Either<Failure, Unit>> addLocation({
    required AddLocationEntity location,
  }) async {
    return await runCatching(() async {
      await _remoteDatasource.addLocation(
        location: AddLocationModel.fromEntity(location),
      );
      return unit;
    });
  }

  @override
  Future<Either<Failure, Unit>> editLocation({
    required EditLocationEntity location,
  }) async {
    return await runCatching(() async {
      await _remoteDatasource.editLocation(
        location: EditLocationModel.fromEntity(location),
      );
      return unit;
    });
  }

  @override
  Future<Either<Failure, bool>> hasAsset({required String id}) async {
    return await runCatching(() async {
      return await _remoteDatasource.hasAsset(id: id);
    });
  }

  @override
  Future<Either<Failure, Unit>> deleteLocation({required String id}) async {
    return await runCatching(() async {
      await _remoteDatasource.deleteLocation(id: id);
      return unit;
    });
  }

  @override
  Future<Either<Failure, Unit>> addRecentLocationSelection({
    required LocationDetailEntity location,
  }) async {
    return await runCatching(() async {
      await _localDatasource.addRecentLocationSelection(
        LocationDetailModel.fromEntity(location),
      );
      return unit;
    });
  }

  @override
  Future<Either<Failure, List<LocationDetailEntity>>>
  getRecentLocationSelections() async {
    return await runCatching(() async {
      final result = await _localDatasource.getRecentLocationSelections();
      return result.map((e) => e.toEntity()).toList();
    });
  }
}
