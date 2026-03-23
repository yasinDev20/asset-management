import 'dart:typed_data';
import 'package:assetmanagement/core/error/exception.dart';
import 'package:assetmanagement/features/asset/data/models/asset_detail_model.dart';
import 'package:assetmanagement/features/asset/data/models/asset_ref_model.dart';
import 'package:assetmanagement/features/asset/data/models/asset_lite_model.dart';
import 'package:assetmanagement/features/asset/data/models/brand_model.dart';
import 'package:assetmanagement/features/asset/data/models/category_model.dart';
import 'package:assetmanagement/features/asset/data/models/location_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AssetRemoteDataSource {
  Future<String> getUrlFile(String path);
  Future<Uint8List> donwloadByPath(String path);
  // Future<String> uploadImage(File fileData, String assetId);
  Future<List<AssetLiteModel>> getAssetsLite(List<Map<String, String>> filters);
  Future<AssetDetailModel> getAssetDetail(String id);

  Future<List<AssetRefModel>> getAssetRefs({
    List<String>? ids,
    List<String>? qrCodes,
  });

  Future<List<BrandModel>> getBrands(String value);
  Future<void> addBrand({required String name, required String ownerId});
  Future<List<CategoryModel>> getCategories(String value);
  Future<void> addCategory({
    required String name,
    required String code,
    required String ownerId,
  });
  Future<List<LocationModel>> getLocations(String value);
  Future<void> addLocation({required String name, required String ownerId});
}

class AssetRemoteDataSourceImpl implements AssetRemoteDataSource {
  final SupabaseClient _supabaseClient;

  AssetRemoteDataSourceImpl({required SupabaseClient supabaseClient})
    : _supabaseClient = supabaseClient;

  @override
  Future<List<AssetLiteModel>> getAssetsLite(
    List<Map<String, String>> filters,
  ) async {
    final query = _supabaseClient.from('assets').select(
      '''id,status,image,qrCode,name,serviceSchedules,
         brandName:brands (name), categoryName:categories (name),
         location:locations (name), owner:users(name)
      ''',
    );

    for (final filter in filters) {
      final column = filter['column'] as String;
      final values = filter['values'] as List;

      query.inFilter(column, values);
    }

    final response = await query;

    return response.map((e) => AssetLiteModel.fromMap(e)).toList();
  }

  @override
  Future<AssetDetailModel> getAssetDetail(String id) async {
    final query = _supabaseClient
        .from('assets')
        .select('''*,
         brand:brands (*), category:categories (*),
         location:locations (*), owner:users(*)
      ''')
        .eq('id', id);

    final response = await query;

    return AssetDetailModel.fromMap(response.first);
  }

  @override
  Future<List<AssetRefModel>> getAssetRefs({
    List<String>? ids,
    List<String>? qrCodes,
  }) async {
    var query = _supabaseClient.from('assets').select('''id, qrCode, name,
        category:categories(name),
        brand:brands(name)    
      ''');

    if (ids != null && qrCodes != null) {
      throw AppException(
        type: ExceptionType.unknown,
        message: 'Only one use parameter, cannot using two parameters',
      );
    } else if (ids != null) {
      query = query.inFilter('id', ids);
    } else if (qrCodes != null) {
      query = query.inFilter('qrCode', qrCodes);
    }

    final response = await query;

    final asetRefModel = response.map((e) => AssetRefModel.fromMap(e)).toList();

    return asetRefModel;
  }

  @override
  Future<String> getUrlFile(String path) async {
    return await _supabaseClient.storage
        .from("assets")
        .createSignedUrl(path, 60);
  }

  @override
  Future<Uint8List> donwloadByPath(String path) async {
    return await _supabaseClient.storage.from("assets").download(path);
  }

  @override
  Future<List<BrandModel>> getBrands(String value) async {
    final response = await _supabaseClient
        .from('brands')
        .select('*')
        .ilike('name', '$value%');
    final brandsModel = response.map((e) => BrandModel.fromMap(e)).toList();
    return brandsModel;
  }

  @override
  Future<void> addBrand({required String name, required String ownerId}) async {
    await _supabaseClient.from('brands').insert({
      'name': name,
      'ownerId': ownerId,
    });
  }

  @override
  Future<void> addCategory({
    required String name,
    required String code,
    required String ownerId,
  }) async {
    await _supabaseClient.from('categories').insert({
      'name': name,
      'code': code,
      'ownerId': ownerId,
    });
  }

  @override
  Future<List<CategoryModel>> getCategories(String value) async {
    final response = await _supabaseClient
        .from('categories')
        .select('*')
        .ilike('name', '$value%');
    final categoriesModel = response
        .map((e) => CategoryModel.fromMap(e))
        .toList();
    return categoriesModel;
  }

  @override
  Future<void> addLocation({required String name, required String ownerId}) async {
    await _supabaseClient.from('locations').insert({
      'name': name,
      'ownerId': ownerId,
    });
  }

  @override
  Future<List<LocationModel>> getLocations(String value) async {
    final response = await _supabaseClient
        .from('locations')
        .select('*')
        .ilike('name', '$value%');
    final locationsModel = response
        .map((e) => LocationModel.fromMap(e))
        .toList();
    return locationsModel;
  }

  // @override
  // Future<String> uploadImage(File fileData, String assetId) async {
  //   throw UnimplementedError();
  //   // final timeStamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
  //   // final fileName = '$timeStamp.png';
  //   // final path = '$assetId/$fileName';

  //   // await _supabaseClient.storage.from('assets').upload(path, fileData);
  //   // await remoteDataSource.saveAssetImagePath(assetId, path);
  // }
}
