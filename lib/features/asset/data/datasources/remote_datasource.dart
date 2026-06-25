import 'dart:typed_data';
import 'package:assetmanagement/core/common/extension/extension.dart';
import 'package:assetmanagement/core/error/exception.dart';
import 'package:assetmanagement/features/asset/data/models/add_asset_model.dart';
import 'package:assetmanagement/features/asset/data/models/asset_detail_model.dart';
import 'package:assetmanagement/features/asset/data/models/asset_filter_model.dart';
import 'package:assetmanagement/features/asset/data/models/asset_ref_model.dart';
import 'package:assetmanagement/features/asset/data/models/asset_summary_model.dart';
import 'package:assetmanagement/features/asset/data/models/asset_template_model.dart';
import 'package:assetmanagement/features/asset/data/models/edit_asset_model.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

abstract class AssetRemoteDataSource {
  Future<String> getUrlFile(String path);
  Future<Uint8List> donwloadByPath(String path);
  Future<String> uploadImage(Uint8List fileData, String fileName);
  Future<List<AssetLiteModel>> getAssetsLite(
    AssetFilterModel? filters, {
    required int page,
    required int pageSize,
  });

  Future<AssetDetailModel> getAssetDetail(String id);

  Future<List<AssetRefModel>> getAssetRefs({String? assetId, String? qrCodes});

  Future<void> addAsset(AddAssetModel addAssetModel);
  Future<void> editAsset({
    required EditAssetModel originalAssetModel,
    required EditAssetModel editAssetModel,
  });
  Future<String> downloadFile({
    required String url,
    required String fileName,
    void Function(double progress)? onProgress,
  });
  Future<void> addToTemplate({required AssetTemplateModel assetTemplateModel});
  Future<void> deleteTemplate(String id);
  Future<List<AssetTemplateModel>> getTemplate({required String search});
}

class AssetRemoteDataSourceImpl implements AssetRemoteDataSource {
  final SupabaseClient _supabaseClient;
  final Dio _dio;

  AssetRemoteDataSourceImpl({
    required SupabaseClient supabaseClient,
    required Dio dio,
  }) : _supabaseClient = supabaseClient,
       _dio = dio;

  @override
  Future<List<AssetLiteModel>> getAssetsLite(
    AssetFilterModel? filters, {
    required int page,
    required int pageSize,
  }) async {
    dynamic query = _supabaseClient.from('assets').select(
      '''id, status, image_path, qr_code, name, service_schedules,
         brand_name:brands (name), category_name:categories (name),
         location:locations (name), owner:users(name)
      ''',
    );

    if (filters?.locations.isNotEmpty == true) {
      query = query.inFilter(
        'location_id',
        filters!.locations.map((e) => e.id).toList(),
      );
    }
    if (filters?.categories.isNotEmpty == true) {
      query = query.inFilter(
        'category_id',
        filters!.categories.map((e) => e.id).toList(),
      );
    }
    if (filters?.brands.isNotEmpty == true) {
      query = query.inFilter(
        'brand_id',
        filters!.brands.map((e) => e.id).toList(),
      );
    }

    if (filters?.vendor.isNotEmpty == true) {
      query = query.ilikeAnyOf('vendor', filters!.vendor.toLikePatterns);
    }
    if (filters?.status.isNotEmpty == true) {
      query = query.inFilter('status', filters!.status);
    }
    if (filters?.qrCode?.isNotEmpty == true) {
      query = query.ilike('qr_code', filters!.qrCode!.toLikePatterns);
    }
    if (filters?.productionYear.isNotEmpty == true) {
      query = query.inFilter('production_year', filters!.productionYear);
    }
    if (filters?.purchaseYear.isNotEmpty == true) {
      query = query.inFilter('purchase_year', filters!.purchaseYear);
    }
    if (filters?.warrantyEndYear.isNotEmpty == true) {
      query = query.inFilter('warranty_end_year', filters!.warrantyEndYear);
    }

    final from = page * pageSize;
    final to = from + pageSize - 1;

    final response = await query.range(from, to) as List<dynamic>;
    return response.map((e) => AssetLiteModel.fromMap(e)).toList();
  }

  @override
  Future<AssetDetailModel> getAssetDetail(String id) async {
    final query = _supabaseClient
        .from('assets')
        .select('''*,
         brand:brands (*),
         category:categories (*),
         location:locations (*),
         owner:users(*),
         asset_parent:parent_id(
          id, qr_code, name,
          category:categories(name),
          brand:brands(name)    
         )
      ''')
        .eq('id', id);

    final response = await query;

    return AssetDetailModel.fromMap(response.first);
  }

  @override
  Future<List<AssetRefModel>> getAssetRefs({
    String? assetId,
    String? qrCodes,
  }) async {
    var query = _supabaseClient.from('assets').select('''id, qr_code, name,
        category:categories(name),
        brand:brands(name)    
      ''');

    if (assetId != null && qrCodes != null) {
      throw AppException(
        type: ExceptionType.unknown,
        message: 'Only use one parameter, cannot using two parameters',
      );
    } else if (assetId != null) {
      query = query.eq('parent_id', assetId);
    } else if (qrCodes != null) {
      query = query.eq('qr_code', qrCodes);
    }

    final response = await query;

    final asetRefModel = response.map((e) => AssetRefModel.fromMap(e)).toList();

    return asetRefModel;
  }

  @override
  Future<String> getUrlFile(String path) async {
    return await _supabaseClient.storage
        .from("assets")
        .createSignedUrl(path, 1000);
  }

  @override
  Future<Uint8List> donwloadByPath(String path) async {
    return await _supabaseClient.storage.from("assets").download(path);
  }

  @override
  Future<String> uploadImage(Uint8List fileData, String fileName) async {
    throw UnimplementedError();
    // final timeStamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
    // final fileName = '$timeStamp.png';
    // final path = '$assetId/$fileName';

    // await _supabaseClient.storage.from('assets').uploadBinary(path, fileData);
  }

  @override
  Future<void> addAsset(AddAssetModel addAssetModel) async {
    final id = const Uuid().v4();
    final imagePath = '$id/images/${addAssetModel.imageFile.name}';
    String? invoicePath;
    if (addAssetModel.invoiceFile != null) {
      invoicePath = '$id/invoices/${addAssetModel.invoiceFile!.name}';
    }

    // 1. Upload file dulu (di luar transaksi DB, karena storage bukan PostgreSQL)
    await Future.wait([
      _supabaseClient.storage
          .from('assets')
          .uploadBinary(imagePath, addAssetModel.imageFile.file),
      if (addAssetModel.invoiceFile != null)
        _supabaseClient.storage
            .from('assets')
            .uploadBinary(invoicePath!, addAssetModel.invoiceFile!.file),
    ]);

    // 2. Panggil satu function PostgreSQL — semua atomik di dalam sini
    await _supabaseClient.rpc(
      'add_asset_transactional',
      params: {
        ...addAssetModel.toMap(),
        'image_path': imagePath,
        'invoice_path': invoicePath,
      },
    );
  }

  @override
  Future<String> downloadFile({
    required String url,
    required String fileName,
    void Function(double progress)? onProgress,
  }) async {
    final dir = await getTemporaryDirectory();
    final path = '${dir.path}/$fileName';

    await _dio.download(
      url,
      path,
      onReceiveProgress: (received, total) {
        if (total != -1) onProgress?.call(received / total);
      },
    );

    return path;
  }

  @override
  Future<void> editAsset({
    required EditAssetModel originalAssetModel,
    required EditAssetModel editAssetModel,
  }) async {
    String? imagePath;

    String? invoicePath;

    if (editAssetModel.invoiceFile != null) {
      invoicePath =
          '${editAssetModel.id}/invoices/${editAssetModel.invoiceFile?.name}';
    }
    if (editAssetModel.imageFile != null) {
      imagePath =
          '${editAssetModel.id}/images/${editAssetModel.imageFile?.name}';
    }

    await Future.wait([
      if (editAssetModel.imageFile != null)
        _supabaseClient.storage
            .from('assets')
            .updateBinary(imagePath!, editAssetModel.imageFile!.file),
      if (editAssetModel.invoiceFile != null)
        _supabaseClient.storage
            .from('assets')
            .updateBinary(invoicePath!, editAssetModel.invoiceFile!.file),
    ]);

    final newFields = {
      ...editAssetModel.toUpdateMap(originalAssetModel),
      if (imagePath != null) 'image_path': imagePath,
      if (invoicePath != null) 'invoice_path': invoicePath,
    };

    await _supabaseClient
        .from('assets')
        .update({...newFields})
        .eq('id', editAssetModel.id);
  }

  @override
  Future<void> addToTemplate({
    required AssetTemplateModel assetTemplateModel,
  }) async {
    await _supabaseClient
        .from('templates')
        .upsert(assetTemplateModel.toMap(), onConflict: 'asset_id');
  }

  @override
  Future<List<AssetTemplateModel>> getTemplate({required String search}) async {
    List<Map<String, dynamic>> response;
    if (search.isEmpty) {
      response = await _supabaseClient.from('templates').select(''' *,
          asset_parrent:assets  (*),
          brand:brands (*), category:categories (*), location:locations(*)
          ''');
    } else {
      response = await _supabaseClient
          .from('templates')
          .select(''' *,
          asset_parrent:assets  (*),
          brand:brands (*), category:categories (*), location:locations(*)
          ''')
          .ilike('template_name', '$search%');
    }

    final assetTemplateModels = response
        .map((e) => AssetTemplateModel.fromMap(e))
        .toList();

    return assetTemplateModels;
  }

  @override
  Future<void> deleteTemplate(String id) async {
    await _supabaseClient.from('templates').delete().eq('id', id);
  }
}
