import 'package:assetmanagement/features/asset_location/data/models/location_detail_model.dart';
import 'package:hive/hive.dart';

abstract class LocationLocalDatasource {
  Future<List<LocationDetailModel>> getRecentLocationSelections();
  Future<void> addRecentLocationSelection(
    LocationDetailModel recentLocationSelection,
  );
}

class LocationLocalDatasourceImpl extends LocationLocalDatasource {
  @override
  Future<List<LocationDetailModel>> getRecentLocationSelections() async {
    var box = Hive.box('recentLocationSelections');

    final result =
        await box.get('recentLocationSelections', defaultValue: []) as List;

    return result
        .map((e) => LocationDetailModel.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  @override
  Future<void> addRecentLocationSelection(
    LocationDetailModel recentLocationSelection,
  ) async {
    var box = Hive.box('recentLocationSelections');

    List listOfRecentLocationSelections = List.from(
      box.get('recentLocationSelections', defaultValue: []),
    );

    // hapus jika location sudah ada
    listOfRecentLocationSelections.removeWhere(
      (location) => location['id'] == recentLocationSelection.id,
    );

    // tambahkan di index 0
    listOfRecentLocationSelections.insert(0, recentLocationSelection.toMap());

    // batasi hanya 5
    if (listOfRecentLocationSelections.length > 5) {
      listOfRecentLocationSelections.removeLast();
    }

    await box.put('recentLocationSelections', listOfRecentLocationSelections);
    await box.flush();
  }
}
