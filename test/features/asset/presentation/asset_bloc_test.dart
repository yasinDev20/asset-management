import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_detail_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_lite_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_ref_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/brand_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/category_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/location_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_detail_result_entity.dart';
import 'package:assetmanagement/features/asset/domain/repositories/asset_repository.dart';
import 'package:assetmanagement/features/asset/domain/usecases/get_asset_detail.dart';
import 'package:assetmanagement/features/asset/domain/usecases/get_assets_lite.dart';
import 'package:assetmanagement/features/asset/presentation/bloc/asset_bloc.dart';
import 'package:assetmanagement/features/authentication/domain/entities/user_entity.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetAssetsUsecase extends Mock implements GetAssetsLiteUsecase {}

class MockGetAssetDetailUsecase extends Mock implements GetAssetDetailUsecase {}

class MockAssetRepository extends Mock implements AssetRepository {}

void main() {
  late MockAssetRepository mockAssetRepository;
  late AssetBloc assetBloc;
  late MockGetAssetsUsecase mockGetAssetsUsecase;
  late MockGetAssetDetailUsecase mockGetAssetDetailUsecase;
  late List<Map<String, String>> filter;
  late AssetLiteEntity assetSummaryEntity;
  late List<AssetLiteEntity> allAssetSummaryEntity;
  late UserEntity userEntity;
  late BrandEntity brandEntity;
  late CategoryEntity categoryEntity;
  late LocationEntity locationEntity;
  late AssetDetailEntity assetDetailEntity;
  late AssetDetailResult assetDetail;
  late AssetRefEntity assetRefEntity;
  setUp(() {
    mockAssetRepository = MockAssetRepository();
    mockGetAssetsUsecase = MockGetAssetsUsecase();
    mockGetAssetDetailUsecase = MockGetAssetDetailUsecase();
    assetBloc = AssetBloc(
      assetRepository: mockAssetRepository,
      getAssetsUsecase: mockGetAssetsUsecase,
      getAssetDetailUsecase: mockGetAssetDetailUsecase,
    );
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
    allAssetSummaryEntity = [assetSummaryEntity, assetSummaryEntity];

    userEntity = UserEntity(
      id: 'id',
      email: 'email',
      name: 'name',
      createdAt: DateTime(2000),
    );
    brandEntity = BrandEntity(id: 'id', ownerId: 'ownerId', name: 'name');
    categoryEntity = CategoryEntity(
      id: 'id',
      ownerId: 'ownerId',
      name: 'name',
      code: 'code',
      lastSequance: 0,
    );
    locationEntity = LocationEntity(id: 'id', ownerId: 'ownerId', name: 'name');
    assetDetailEntity = AssetDetailEntity(
      id: 'id',
      ownerId: 'ownerId',
      imagePath: 'image',
      qrCode: 'qrCode',
      serialNumber: 'serialNumber',
      name: 'name',
      brandId: 'brandId',
      categoryId: 'categoryId',
      price: 0,
      productionYear: 2000,
      locationId: 'locationId',
      status: 'status',
      vendor: 'vendor',
      purchaseYear: 2000,
      warrantyEndYear: 2000,
      serviceSchedules: [
        {'serviceSchedules': 'serviceSchedules'},
      ],
      assetParent: AssetRefEntity(
          id: 'id',
          categoryName: 'categoryName',
          qrCode: 'qrCode',
          brandName: 'brandName',
          name: 'name',
        ),
      assetChilds: [
        AssetRefEntity(
          id: 'id',
          categoryName: 'categoryName',
          qrCode: 'qrCode',
          brandName: 'brandName',
          name: 'name',
        ),
      ],
      invoicePath: 'invoice',
      notes: 'notes',
      createdAt: 'createdAt',
      updatedAt: 'updatedAt',
      owner: userEntity,
      brand: brandEntity,
      category: categoryEntity,
      location: locationEntity,
    );

    assetDetail =AssetDetailResult(assetDetailEntity: assetDetailEntity, imageUrl: 'imageUrl', invoiceUrl: 'invoiceUrl');

    assetRefEntity = AssetRefEntity(
      id: 'id',
      categoryName: 'categoryName',
      qrCode: 'qrCode',
      brandName: 'brandName',
      name: 'name',
    );
  });

  group('GetAssetLiteEvent', () {
    blocTest<AssetBloc, AssetState>(
      'emits [AssetLoadingState, GetAssetsSuccsessState] when GetAssetsEvent is added',
      build: () {
        when(
          () => mockGetAssetsUsecase.call(filter),
        ).thenAnswer((_) async => Right(allAssetSummaryEntity));
        return assetBloc;
      },
      act: (bloc) {
        bloc.add(GetAssetsLiteEvent([]));
      },
      expect: () => [
        AssetLoadingState(),
        GetAssetsLiteSuccessState(assets: allAssetSummaryEntity),
      ],
      verify: (_) {
        verify(() => mockGetAssetsUsecase(filter)).called(1);
      },
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
      act: (bloc) => bloc.add(GetAssetsLiteEvent(filter)),
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
  group('GetAssetDetailEvent', () {
    blocTest<AssetBloc, AssetState>(
      'emits [AssetLoadingState, GetAssetDetailSuccsessState] when GetAssetDetailEvent is added',
      build: () {
        when(
          () => mockGetAssetDetailUsecase.call('id'),
        ).thenAnswer((_) async => Right(assetDetail));
        return assetBloc;
      },
      act: (bloc) {
        bloc.add(GetAssetDetailEvent('id'));
      },
      expect: () => [
        AssetLoadingState(),
        GetAssetDetailSuccsessState(assetDetail: assetDetail),
      ],
      verify: (_) {
        verify(() => mockGetAssetDetailUsecase('id')).called(1);
      },
    );

    blocTest<AssetBloc, AssetState>(
      'emits [AssetLoadingState, AssetFailureState] when GetAssetDetailEvent handler fails',
      build: () {
        // stub usecase.call(...) -> Left(Failure)
        when(() => mockGetAssetDetailUsecase.call('id')).thenAnswer(
          (_) async => Left(
            NetworkFailure(message: 'Network Failure', code: 'NETWORK_FAILURE'),
          ),
        );
        return assetBloc;
      },
      act: (bloc) => bloc.add(GetAssetDetailEvent('id')),
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
        verify(() => mockGetAssetDetailUsecase('id')).called(1);
      },
    );
  });
  group('GetAssetRefEvent', () {
    blocTest<AssetBloc, AssetState>(
      'emits [AssetLoadingState, GetAssetRefSuccsessState] when GetAssetRefEvent is added',
      build: () {
        when(
          () => mockAssetRepository.getAssetRefs(assetId: ['id']),
        ).thenAnswer((_) async => Right([assetRefEntity]));
        return assetBloc;
      },
      act: (bloc) {
        bloc.add(GetAssetRefEvent(ids: ['id']));
      },
      expect: () => [
        AssetLoadingState(),
        GetAssetRefSuccsessState(assetRefEntity: [assetRefEntity]),
      ],
      verify: (_) {
        verify(() => mockAssetRepository.getAssetRefs(assetId: ['id'])).called(1);
      },
    );

    blocTest<AssetBloc, AssetState>(
      'emits [AssetLoadingState, AssetFailureState] when GetAssetRefEvent handler fails',
      build: () {
        when(() => mockAssetRepository.getAssetRefs(assetId: ['id'])).thenAnswer(
          (_) async => Left(
            NetworkFailure(message: 'Network Failure', code: 'NETWORK_FAILURE'),
          ),
        );
        return assetBloc;
      },
      act: (bloc) => bloc.add(GetAssetRefEvent(ids: ['id'])),
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
        verify(() => mockAssetRepository.getAssetRefs(assetId: ['id'])).called(1);
      },
    );
  });
}
