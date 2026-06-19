import 'package:assetmanagement/features/asset_category/data/models/add_category_model.dart';
import 'package:assetmanagement/features/asset_category/data/models/category_detail_model.dart';
import 'package:assetmanagement/features/asset_category/data/models/edit_category_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class CategoryRemoteDatasource {
  Future<List<CategoryDetailModel>> searchCategories({required String value});
  Future<CategoryDetailModel> getCategory({required String id});
  Future<void> addCategory({required AddCategoryModel category});
  Future<void> editCategory({required EditCategoryModel category});
  Future<bool> hasAsset({required String id});
  Future<void> deleteCategory({required String id});
}

class CategoryRemoteDatasourceImpl extends CategoryRemoteDatasource {
  final SupabaseClient _supabaseClient;

  CategoryRemoteDatasourceImpl({required SupabaseClient supabaseClient})
    : _supabaseClient = supabaseClient;

  @override
  Future<List<CategoryDetailModel>> searchCategories({
    required String value,
  }) async {
    var query = _supabaseClient.from('categories').select('*');
    if (value.isNotEmpty) {
      query = query.ilike('name', '$value%');
    }
    final response = await query;
    final categoriesModel = response
        .map((e) => CategoryDetailModel.fromMap(e))
        .toList();
    return categoriesModel;
  }

  @override
  Future<CategoryDetailModel> getCategory({required String id}) async {
    var query = _supabaseClient.from('categories').select('*').eq('id', id);

    final response = await query;
    final categoriesModel = CategoryDetailModel.fromMap(response.first);

    return categoriesModel;
  }

  @override
  Future<void> addCategory({required AddCategoryModel category}) async {
    await _supabaseClient.from('categories').insert({
      'name': category.name,
      'code': category.code,
    });
  }

  @override
  Future<void> editCategory({required EditCategoryModel category}) async {
    await _supabaseClient
        .from('categories')
        .update({'name': category.name, 'code': category.code})
        .eq('id', category.id);
  }

  @override
  Future<void> deleteCategory({required String id}) async {
    await _supabaseClient.from('categories').delete().eq('id', id);
  }

  @override
  Future<bool> hasAsset({required String id}) async {
    final data = await _supabaseClient
        .from('assets')
        .select('id')
        .eq('category_id', id)
        .limit(1);

    final hasAssets = data.isNotEmpty;

    return hasAssets;
  }
}
