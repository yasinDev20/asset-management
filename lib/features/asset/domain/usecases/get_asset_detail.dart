
import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/asset/domain/models/asset_detail_model.dart';
import 'package:assetmanagement/features/asset/domain/repositories/asset_repository.dart';
import 'package:dartz/dartz.dart';

class GetAssetDetailUsecase {
  final AssetRepository _assetRepository;

  GetAssetDetailUsecase(this._assetRepository);

  Future<Either<Failure, AssetDetail>> call(String id) async {
    final assetResult = await _assetRepository.getAssetDetail(id);

    if (assetResult.isLeft()) {
      return Left(assetResult.swap().getOrElse(() => throw Exception()));
    }

    final assetEntity = assetResult.getOrElse(() => throw Exception());

    final imageResult = await _assetRepository.getUrl(assetEntity.imagePath);
    if (imageResult.isLeft()) {
      return Left(imageResult.swap().getOrElse(() => throw Exception()));
    }

    final imageUrl = imageResult.getOrElse(() => throw Exception());

    String? invoiceUrl;

    if (assetEntity.invoicePath != null) {
      final invoiceResult =
          await _assetRepository.getUrl(assetEntity.invoicePath!);

      if (invoiceResult.isLeft()) {
        return Left(invoiceResult.swap().getOrElse(() => throw Exception()));
      }

      invoiceUrl =
          invoiceResult.getOrElse(() => throw Exception());
    }

    return Right(
      AssetDetail(
        assetDetailEntity: assetEntity,
        imageUrl: imageUrl,
        invoiceFile: null,
      ),
    );
  }
  
} 