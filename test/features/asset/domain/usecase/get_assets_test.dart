import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_lite_entity.dart';
import 'package:assetmanagement/features/asset/domain/repositories/asset_repository.dart';
import 'package:assetmanagement/features/asset/domain/usecases/get_assets_lite.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAssetRepository extends Mock implements AssetRepository {}

void main() {
  late GetAssetsLiteUsecase getAssetsUsecase;
  late MockAssetRepository mockAssetRepository;
  late List<AssetLiteEntity> allAssetsSummaryEntity;
  late AssetLiteEntity assetSummaryEntity;
  late List<Map<String, String>> filter;

  setUp(() {
    mockAssetRepository = MockAssetRepository();
    getAssetsUsecase = GetAssetsLiteUsecase(mockAssetRepository);
    filter = [];
    assetSummaryEntity = AssetLiteEntity(
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
    allAssetsSummaryEntity = [assetSummaryEntity, assetSummaryEntity];
  });

  test('should return List<AssetEntity> when get assets succeeds', () async {
    when(
      () => mockAssetRepository.getAssetsLite(filter),
    ).thenAnswer((_) async => Right(allAssetsSummaryEntity));
    final result = await getAssetsUsecase.call(filter);

    expect(result, equals(Right(allAssetsSummaryEntity)));
  });

  test('should return Failure when get assets fails', () async {
    when(() => mockAssetRepository.getAssetsLite(filter)).thenAnswer(
      (_) async => Left(
        NetworkFailure(message: 'Network Failure', code: 'NETWORK_FAILURE'),
      ),
    );
    final result = await getAssetsUsecase.call(filter);

    expect(
      result,
      equals(
        Left(
          NetworkFailure(message: 'Network Failure', code: 'NETWORK_FAILURE'),
        ),
      ),
    );
    result.fold(
      (l) => expect(l, isA<NetworkFailure>()),
      (r) => 'Should return Left Failure',
    );
  });
}
