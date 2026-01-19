import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_summary_entity.dart';
import 'package:assetmanagement/features/asset/domain/usecases/get_assets.dart';
import 'package:assetmanagement/features/asset/presentation/bloc/asset_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetAssetsUsecase extends Mock implements GetAssetsUsecase {}

void main() {
  late AssetBloc assetBloc;
  late MockGetAssetsUsecase mockGetAssetsUsecase;
  late List<Map<String,String>> filter;
  late AssetSummaryEntity assetSummaryEntity;
  late List<AssetSummaryEntity> allAssetSummaryEntity;
  setUp(() {
    mockGetAssetsUsecase = MockGetAssetsUsecase();
    assetBloc = AssetBloc(getAssetsUsecase: mockGetAssetsUsecase);
    filter = [];
    assetSummaryEntity = AssetSummaryEntity(
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
    allAssetSummaryEntity = [assetSummaryEntity, assetSummaryEntity];
     
  });

  group('GetAssetEvent', () {
    blocTest<AssetBloc, AssetState>(
      'emits [AssetLoadingState, GetAssetsSuccsessState] when GetAssetsEvent is added',
      build: () {
        when(
          () => mockGetAssetsUsecase.call(filter),
        ).thenAnswer((_) async => Right(allAssetSummaryEntity));
        return assetBloc;
      },
      act: (bloc) {
        bloc.add(GetAssetsEvent([]));
      },
      expect: () => [AssetLoadingState(), GetAssetsSuccsessState(allAsset: [])],
    );

    blocTest<AssetBloc, AssetState>(
      'emits [AssetLoadingState, AssetFailureState] when GetAssetsEvent handler fails',
      build: () {
        // stub usecase.call(...) -> Left(Failure)
        when(() => mockGetAssetsUsecase.call(filter)).thenAnswer(
          (_) async => Left(
            NetworkFailure(message: 'Network Failure', code: 'NETWORK_FAILURE'),
          ),
        );
        return assetBloc;
      },
      act: (bloc) => bloc.add(GetAssetsEvent(filter)),
      expect: () => [
        AssetLoadingState(),
        AssetFailureState(
          failure: NetworkFailure(
            message: 'Network Failure',
            code: 'NETWORK_FAILURE',
          ),
        ),
      ],
      verify: (_) {
        verify(() => mockGetAssetsUsecase(filter)).called(1);
      },
    );
  });
}
