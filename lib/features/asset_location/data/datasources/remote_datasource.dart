import 'package:assetmanagement/features/asset_location/data/models/add_location_model.dart';
import 'package:assetmanagement/features/asset_location/data/models/location_detail_model.dart';
import 'package:assetmanagement/features/asset_location/data/models/edit_location_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class LocationRemoteDatasource {
  Future<List<LocationDetailModel>> searchLocations({required String value});
  Future<LocationDetailModel> getLocation({required String id});
  Future<void> addLocation({required AddLocationModel location});
  Future<void> editLocation({required EditLocationModel location});
  Future<bool> hasAsset({required String id});
  Future<void> deleteLocation({required String id});
}

class LocationRemoteDatasourceImpl extends LocationRemoteDatasource {
  final SupabaseClient _supabaseClient;

  LocationRemoteDatasourceImpl({required SupabaseClient supabaseClient})
    : _supabaseClient = supabaseClient;

  @override
  Future<List<LocationDetailModel>> searchLocations({
    required String value,
  }) async {
    var query = _supabaseClient.from('locations').select('*');

    if (value.isNotEmpty) {
      query = query.ilike('name', '$value%');
    }

    final response = await query;
    final locationsModel = response
        .map((e) => LocationDetailModel.fromMap(e))
        .toList();
    return locationsModel;
  }

  @override
  Future<LocationDetailModel> getLocation({required String id}) async {
    final response = await _supabaseClient
        .from('locations')
        .select('*')
        .eq('id', id);

    final locationModel = LocationDetailModel.fromMap(response.first);

    return locationModel;
  }

  @override
  Future<void> addLocation({required AddLocationModel location}) async {
    await _supabaseClient.from('locations').insert({'name': location.name});
  }

  @override
  Future<void> editLocation({required EditLocationModel location}) async {
    await _supabaseClient
        .from('locations')
        .update({'name': location.name})
        .eq('id', location.id);
  }

  @override
  Future<void> deleteLocation({required String id}) async {
    await _supabaseClient.from('locations').delete().eq('id', id);
  }

  @override
  Future<bool> hasAsset({required String id}) async {
    final data = await _supabaseClient
        .from('assets')
        .select('id')
        .eq('location_id', id)
        .limit(1);

    final hasAssets = data.isNotEmpty;

    return hasAssets;
  }
}
