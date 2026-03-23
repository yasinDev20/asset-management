import 'package:assetmanagement/core/error/exception.dart';
import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/asset/data/datasources/remote_datasource.dart';
import 'package:assetmanagement/features/asset/data/models/asset_lite_model.dart';
import 'package:assetmanagement/features/asset/data/repositories/asset_repository_impl.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_lite_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MockAssetRemoteDataSource extends Mock implements AssetRemoteDataSource {}

class MockSupabaseClient extends Mock implements SupabaseClient {}

void main() {
  late MockAssetRemoteDataSource mockAssetRemoteDataSource;
  late MockSupabaseClient mockSupabaseClient;
  late AssetRepositoryImpl assetRepositoryImpl;
  late List<Map<String, String>> filter;
  late AssetLiteModel assetLiteModel;
  late List<AssetLiteModel> allAssetLiteModel;
  late List<AssetLiteEntity> allAssetLiteEntity;

  setUp(() {
    mockAssetRemoteDataSource = MockAssetRemoteDataSource();
    mockSupabaseClient = MockSupabaseClient();
    assetRepositoryImpl = AssetRepositoryImpl(
      assetRemoteDataSource: mockAssetRemoteDataSource,
      supabaseClient: mockSupabaseClient,
    );
    filter = [];
    assetLiteModel = AssetLiteModel(
      id: 'id',
      status: 'status',
      image: 'image',
      categoryName: 'categoryName',
      qrCode: 'qrCode',
      brandName: 'brandName',
      name: 'name',
      location: 'location',
      nextServiceSchedule: DateTime(2000),
    );
    allAssetLiteModel = [assetLiteModel, assetLiteModel];
    allAssetLiteEntity = allAssetLiteModel
        .map((e) => e.toEntity(imageUrl: 'image'))
        .toList();
  });

  group('getAssetsLite', () {
    test('should return List<AssetEntity> when get assets succeeds', () async {
      
      when(
        () => mockAssetRemoteDataSource.getAssetsLite(filter),
      ).thenAnswer((_) async => allAssetLiteModel);

      final result = await assetRepositoryImpl.getAssetsLite(filter);

      result.fold(
        (l) => fail('Expected Right but got $l'),
        (r) => expect(r, allAssetLiteEntity),
      );

      verify(() => mockAssetRemoteDataSource.getAssetsLite(filter)).called(1);
      
    });

    test('should return Failure when getAssetsLite throws exception', () async {
      when(() => mockAssetRemoteDataSource.getAssetsLite(filter)).thenThrow(
        AppException(
          type: ExceptionType.network,
          code: 'NETWORK_ERROR',
          message: 'Network Failure',
        ),
      );

      final result = await assetRepositoryImpl.getAssetsLite(filter);

      expect(result.isLeft(), true);

      result.fold((failure) {
        expect(failure, isA<NetworkFailure>());
        expect(failure.message, 'Network Failure');
        expect(failure.code, 'NETWORK_ERROR');
      }, (_) => fail('Should not return Right'));

      verify(() => mockAssetRemoteDataSource.getAssetsLite(filter)).called(1);
    });
  });
  group('getAssetsLite', () {
    // TODO:Lengkapi test
    test('should return List<AssetEntity> when get assets succeeds', () async {
     
      when(
        () => mockAssetRemoteDataSource.getAssetsLite(filter),
      ).thenAnswer((_) async => allAssetLiteModel);

      final result = await assetRepositoryImpl.getAssetsLite(filter);

      result.fold(
        (l) => fail('Expected Right but got $l'),
        (r) => expect(r, allAssetLiteEntity),
      );

      verify(() => mockAssetRemoteDataSource.getAssetsLite(filter)).called(1);
      
    });

    test('should return Failure when getAssetsLite throws exception', () async {
      when(() => mockAssetRemoteDataSource.getAssetsLite(filter)).thenThrow(
        AppException(
          type: ExceptionType.network,
          code: 'NETWORK_ERROR',
          message: 'Network Failure',
        ),
      );

      final result = await assetRepositoryImpl.getAssetsLite(filter);

      expect(result.isLeft(), true);

      result.fold((failure) {
        expect(failure, isA<NetworkFailure>());
        expect(failure.message, 'Network Failure');
        expect(failure.code, 'NETWORK_ERROR');
      }, (_) => fail('Should not return Right'));

      verify(() => mockAssetRemoteDataSource.getAssetsLite(filter)).called(1);
    });
  });
}
