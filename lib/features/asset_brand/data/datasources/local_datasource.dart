import 'package:assetmanagement/features/asset_brand/data/models/brand_detail_model.dart';
import 'package:hive/hive.dart';

abstract class BrandLocalDatasource {
  Future<List<BrandDetailModel>> getRecentBrandSelections();
  Future<void> addRecentBrandSelection(BrandDetailModel recentBrandSelection);
}

class BrandLocalDatasourceImpl extends BrandLocalDatasource {
  @override
  Future<List<BrandDetailModel>> getRecentBrandSelections() async {
    var box = Hive.box('recentBrandSelections');

    final result =
        await box.get('recentBrandSelections', defaultValue: []) as List;

    return result
        .map((e) => BrandDetailModel.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  @override
  Future<void> addRecentBrandSelection(BrandDetailModel recentBrandSelection) async {
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
}
