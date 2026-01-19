import 'package:assetmanagement/core/error/exception.dart';
import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/asset/data/datasources/remote_datasource.dart';
import 'package:assetmanagement/features/asset/data/models/asset_summary_model.dart';
import 'package:assetmanagement/features/asset/data/repositories/asset_repository_impl.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_summary_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAssetRemoteDataSource extends Mock implements AssetRemoteDataSource {}

void main() {
  late MockAssetRemoteDataSource mockAssetRemoteDataSource;
  late AssetRepositoryImpl assetRepositoryImpl;
  late List<Map<String, String>> filter;
  late AssetSummaryModel assetSummaryModel;
  late List<AssetSummaryModel> allAssetSummaryModel;
  late List<AssetSummaryEntity> allAssetSummaryEntity;

  setUp(() {
    mockAssetRemoteDataSource = MockAssetRemoteDataSource();
    assetRepositoryImpl = AssetRepositoryImpl(mockAssetRemoteDataSource);
    filter = [];
    assetSummaryModel = AssetSummaryModel(
      id: 'id',
      status: 'status',
      image: 'image',
      categoryName: 'categoryName',
      qrCode: 'qrCode',
      brandName: 'brandName',
      name: 'name',
      location: 'location',
      nextServiceSchedule: 'nextServiceSchedule',
    );
    allAssetSummaryModel = [assetSummaryModel, assetSummaryModel];
    allAssetSummaryEntity = allAssetSummaryModel.map((e) => e.toEntity()).toList();
  });

  group('getAssets', () {
    test('should return List<AssetEntity> when get assets succeeds', () async {
      when(
        () => mockAssetRemoteDataSource.getAssets(filter),
      ).thenAnswer((_) async => allAssetSummaryModel);
      final result = await assetRepositoryImpl.getAssets(filter);

      result.fold(
        (l) => fail('Expected Right but got $l'),
        (r) => expect(r, allAssetSummaryEntity),
      );

      verify(() => mockAssetRemoteDataSource.getAssets(filter)).called(1);
    });

    test('should return Failure when get assets throws exception', () async {
      when(() => mockAssetRemoteDataSource.getAssets(filter)).thenThrow(
        AppException(
          type: ExceptionType.network,
          code: 'NETWORK_ERROR',
          message: 'Network Failure',
        ),
      );

      final result = await assetRepositoryImpl.getAssets(filter);

      expect(result.isLeft(), true);

      result.fold((failure) {
        expect(failure, isA<NetworkFailure>());
        expect(failure.message, 'Network Failure');
        expect(failure.code, 'NETWORK_ERROR');
      }, (_) => fail('Should not return Right'));

      verify(() => mockAssetRemoteDataSource.getAssets(filter)).called(1);
    });
  });
}
