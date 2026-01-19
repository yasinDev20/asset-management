import 'package:assetmanagement/features/asset/data/models/asset_summary_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AssetRemoteDataSource {
  Future<List<AssetSummaryModel>> getAssets(List<Map<String, String>> filters);
}

class AssetRemoteDataSourceImpl implements AssetRemoteDataSource {
  final SupabaseClient supabaseClient;

  AssetRemoteDataSourceImpl({required this.supabaseClient});
  @override
  Future<List<AssetSummaryModel>> getAssets(
    List<Map<String, String>> filters,
  ) async {
    final query = supabaseClient.from('assets').select(
      '''id,status,image,qrCode,name,serviceSchedules, brandName:brands (name), categoryName:categories (name), location:locations (name), owner:users(name)''',
    );

    for (final filter in filters) {
      final column = filter['column'] as String;
      final values = filter['values'] as List;

      query.inFilter(column, values);
    }

    final response = await query;

    return (response as List).map((e) => AssetSummaryModel.fromMap(e)).toList();
  }
}
