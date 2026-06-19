import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_detail_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_ref_entity.dart';
import 'package:assetmanagement/features/asset_brand/domain/entities/brand_detail_entity.dart';
import 'package:assetmanagement/features/asset_category/domain/entities/category_detail_entity.dart';
import 'package:assetmanagement/features/asset_location/domain/entities/location_detail_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_detail_result_entity.dart';
import 'package:assetmanagement/features/asset/domain/repositories/asset_repository.dart';
import 'package:assetmanagement/features/asset/domain/usecases/get_asset_detail.dart';
import 'package:assetmanagement/features/authentication/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAssetRepository extends Mock implements AssetRepository {}

void main() {
  late GetAssetDetailUsecase getAssetDetailUsecase;
  late MockAssetRepository mockAssetRepository;
  late UserEntity userEntity;
  late BrandDetailEntity brandEntity;
  late CategoryDetailEntity categoryEntity;
  late LocationEntity locationEntity;
  late AssetDetailEntity assetDetailEntity;
  late AssetDetailResult assetDetail;

  setUp(() {
    mockAssetRepository = MockAssetRepository();
    getAssetDetailUsecase = GetAssetDetailUsecase(mockAssetRepository);
    userEntity = UserEntity(
      id: 'id',
      email: 'email',
      name: 'name',
      createdAt: DateTime(2000),
    );
    brandEntity = BrandDetailEntity(id: 'id', ownerId: 'ownerId', name: 'name');
    categoryEntity = CategoryDetailEntity(
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

    assetDetail = AssetDetailResult(assetDetailEntity: assetDetailEntity, imageUrl: 'imageUrl', invoiceUrl: 'invoiceUrl');
  });

  test('should return AssetDetail when get assets succeeds', () async {
    when(
      () => mockAssetRepository.getAssetDetail(any()),
    ).thenAnswer((_) async => Right(assetDetailEntity));
    
    when(
      () => mockAssetRepository.getUrl(assetDetailEntity.imagePath),
    ).thenAnswer((_) async => Right('imageUrl'));
    when(
      () => mockAssetRepository.getUrl(assetDetailEntity.invoicePath!),
    ).thenAnswer((_) async => Right('invoiceUrl'));


    final result = await getAssetDetailUsecase.call('id');

    expect(result, equals(Right(assetDetail)));
    verify(() => mockAssetRepository.getUrl(assetDetailEntity.imagePath)).called(1);
    verify(() => mockAssetRepository.getUrl(assetDetailEntity.invoicePath!)).called(1);
  });

  test('should return Failure when get assets fails', () async {
    when(() => mockAssetRepository.getAssetDetail('id')).thenAnswer(
      (_) async => Left(
        NetworkFailure(message: 'Network Failure', code: 'NETWORK_FAILURE'),
      ),
    );
    final result = await getAssetDetailUsecase.call('id');

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

  test('should return Failure when get image url fails', () async {
    when(
      () => mockAssetRepository.getAssetDetail(any()),
    ).thenAnswer((_) async => Right(assetDetailEntity));
    
    when(
      () => mockAssetRepository.getUrl(assetDetailEntity.imagePath),
    ).thenAnswer((_) async => Left(NetworkFailure(message: 'Network Failure', code: 'NETWORK_FAILURE')));
    when(
      () => mockAssetRepository.getUrl(assetDetailEntity.invoicePath!),
    ).thenAnswer((_) async => Right('invoiceUrl'));


    final result = await getAssetDetailUsecase.call('id');

    expect(result, equals( Left(NetworkFailure(message: 'Network Failure', code: 'NETWORK_FAILURE'))));
    
  });
  test('should return Failure when get invoice url fails', () async {
    when(
      () => mockAssetRepository.getAssetDetail(any()),
    ).thenAnswer((_) async => Right(assetDetailEntity));
    
    when(
      () => mockAssetRepository.getUrl(assetDetailEntity.invoicePath!),
    ).thenAnswer((_) async => Left(NetworkFailure(message: 'Network Failure', code: 'NETWORK_FAILURE')));
    when(
      () => mockAssetRepository.getUrl(assetDetailEntity.imagePath),
    ).thenAnswer((_) async => Right('imageUrl'));


    final result = await getAssetDetailUsecase.call('id');

    expect(result, equals( Left(NetworkFailure(message: 'Network Failure', code: 'NETWORK_FAILURE'))));
    
  });

}



