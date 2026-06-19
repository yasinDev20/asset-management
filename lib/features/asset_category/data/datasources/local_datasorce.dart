import 'package:assetmanagement/features/asset_category/data/models/category_detail_model.dart';
import 'package:hive/hive.dart';

abstract class CategoryLocalDatasource {
  Future<List<CategoryDetailModel>> getRecentCategorySelections();
  Future<void> addRecentCategorySelections(
    CategoryDetailModel recentCategorySelection,
  );
}

class CategoryLocalDatasourceImpl extends CategoryLocalDatasource{
  
  @override
  Future<void> addRecentCategorySelections(
    CategoryDetailModel recentCategorySelection,
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
  Future<List<CategoryDetailModel>> getRecentCategorySelections() async {
    var box = Hive.box('recentCategorySelections');

    final result =
        await box.get('recentCategorySelections', defaultValue: []) as List;

    return result
        .map((e) => CategoryDetailModel.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

}