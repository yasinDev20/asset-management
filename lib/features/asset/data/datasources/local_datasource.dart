import 'package:assetmanagement/features/asset/data/models/brand_model.dart';
import 'package:assetmanagement/features/asset/data/models/category_model.dart';
import 'package:assetmanagement/features/asset/data/models/location_model.dart';
import 'package:hive/hive.dart';

abstract class AssetLocalDataSource {
  Future<List<BrandModel>> getRecentBrandSelections();
  Future<void> addRecentBrandSelections(BrandModel recentBrandSelection);
  Future<List<CategoryModel>> getRecentCategorySelections();
  Future<void> addRecentCategorySelections(
    CategoryModel recentCategorySelection,
  );
  Future<List<LocationModel>> getRecentLocationSelections();
  Future<void> addRecentLocationSelections(
    LocationModel recentLocationSelection,
  );
}

class AssetLocalDatasourceImpl extends AssetLocalDataSource {
  @override
  Future<List<BrandModel>> getRecentBrandSelections() async {
    var box = Hive.box('recentBrandSelections');

    final result =
        await box.get('recentBrandSelections', defaultValue: []) as List;

    return result
        .map((e) => BrandModel.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  @override
  Future<void> addRecentBrandSelections(BrandModel recentBrandSelection) async {
    var box = Hive.box('recentBrandSelections');

    List listOfRecentBrandSelections = List.from(
      box.get('recentBrandSelections', defaultValue: []),
    );

    // hapus jika brand sudah ada
    listOfRecentBrandSelections.removeWhere(
      (brand) => brand['id'] == recentBrandSelection.id,
    );

    // tambahkan di index 0
    listOfRecentBrandSelections.insert(0, recentBrandSelection.toMap());

    // batasi hanya 5
    if (listOfRecentBrandSelections.length > 5) {
      listOfRecentBrandSelections.removeLast();
    }

    await box.put('recentBrandSelections', listOfRecentBrandSelections);
    await box.flush();
  }

  @override
  Future<void> addRecentCategorySelections(
    CategoryModel recentCategorySelection,
  ) async {
    var box = Hive.box('recentCategorySelections');

    List listOfRecentCategorySelections =
         List.from(box.get('recentCategorySelections', defaultValue: []));

    // hapus jika brand sudah ada
    listOfRecentCategorySelections.removeWhere(
      (category) => category['id'] == recentCategorySelection.id,
    );

    // tambahkan di index 0
    listOfRecentCategorySelections.insert(0, recentCategorySelection.toMap());

    // batasi hanya 5
    if (listOfRecentCategorySelections.length > 5) {
      listOfRecentCategorySelections.removeLast();
    }

    await box.put('recentCategorySelections', listOfRecentCategorySelections);
    await box.flush();
  }

  @override
  Future<List<CategoryModel>> getRecentCategorySelections() async {
    var box = Hive.box('recentCategorySelections');

    final result =
        await box.get('recentCategorySelections', defaultValue: []) as List;

    return result
        .map((e) => CategoryModel.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  @override
  Future<void> addRecentLocationSelections(
    LocationModel recentLocationSelection,
  ) async {
    var box = Hive.box('recentLocationSelections');

    List listOfRecentLocationSelections =
         List.from(box.get('recentLocationSelections', defaultValue: []));

    // hapus jika brand sudah ada
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

  @override
  Future<List<LocationModel>> getRecentLocationSelections() async {
    var box = Hive.box('recentLocationSelections');

    final result =
        await box.get('recentLocationSelections', defaultValue: []) as List;

    return result
        .map((e) => LocationModel.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }
}
