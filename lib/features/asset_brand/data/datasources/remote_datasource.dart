import 'package:assetmanagement/features/asset_brand/data/models/add_brand_model.dart';
import 'package:assetmanagement/features/asset_brand/data/models/brand_detail_model.dart';
import 'package:assetmanagement/features/asset_brand/data/models/edit_brand_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BrandRemoteDatasource {
  Future<List<BrandDetailModel>> searchBrands({required String value});
  Future<BrandDetailModel> getBrand({required String id});
  Future<void> addBrand({required AddBrandModel brand});
  Future<void> editBrand({required EditBrandModel brand});
  Future<bool> hasAsset({required String id});
  Future<void> deleteBrand({required String id});
}

class BrandRemoteDatasourceImpl extends BrandRemoteDatasource {
  final SupabaseClient _supabaseClient;

  BrandRemoteDatasourceImpl({required SupabaseClient supabaseClient})
    : _supabaseClient = supabaseClient;

  @override
  Future<List<BrandDetailModel>> searchBrands({required String value}) async {
    var query = _supabaseClient.from('brands').select('*');

    if (value.isNotEmpty) {
      query = query.ilike('name', '$value%');
    }

    final response = await query;
    final brandsModel = response
        .map((e) => BrandDetailModel.fromMap(e))
        .toList();
    return brandsModel;
  }

  @override
  Future<BrandDetailModel> getBrand({required String id}) async {
    final response = await _supabaseClient
        .from('brands')
        .select('*')
        .eq('id', id);

    final brandModel = BrandDetailModel.fromMap(response.first);

    return brandModel;
  }

  @override
  Future<void> addBrand({required AddBrandModel brand}) async {
    await _supabaseClient.from('brands').insert({'name': brand.name});
  }

  @override
  Future<void> editBrand({required EditBrandModel brand}) async {
    await _supabaseClient
        .from('brands')
        .update({'name': brand.name})
        .eq('id', brand.id);
  }

  @override
  Future<void> deleteBrand({required String id}) async {
    await _supabaseClient.from('brands').delete().eq('id', id);
  }
  
  @override
  Future<bool> hasAsset({required String id}) async {
    final data = await _supabaseClient
        .from('assets')
        .select('id')
        .eq('brand_id', id)
        .limit(1);

    final hasAssets = data.isNotEmpty;

    return hasAssets;
  }
}
