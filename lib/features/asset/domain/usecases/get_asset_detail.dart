import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_detail_result_entity.dart';
import 'package:assetmanagement/features/asset/domain/repositories/asset_repository.dart';
import 'package:dartz/dartz.dart';

class GetAssetDetailUsecase {
  final AssetRepository _assetRepository;

  GetAssetDetailUsecase(this._assetRepository);

  Future<Either<Failure, AssetDetailResult>> call(String id) async {
    //get assetDetail
    final assetResult = await _assetRepository.getAssetDetail(id);

    if (assetResult.isLeft()) {
      return Left(assetResult.swap().getOrElse(() => throw Exception()));
    }

    final assetDetailEntity = assetResult.getOrElse(() => throw Exception());

    //get childs
    final childsResult = await _assetRepository.getAssetRefs(assetId: id);

     if (childsResult.isLeft()) {
      return Left(assetResult.swap().getOrElse(() => throw Exception()));
    }

    final childsEntity = childsResult.getOrElse(() =>  throw Exception(),);

    //get image
    final imageResult = await _assetRepository.getUrl(
      assetDetailEntity.imagePath,
    );
    if (imageResult.isLeft()) {
      return Left(imageResult.swap().getOrElse(() => throw Exception()));
    }

    final imageUrl = imageResult.getOrElse(() => throw Exception());
    
   //get invoice when invoicePath not null
    String? invoiceUrl;
    if (assetDetailEntity.invoicePath != null) {
      final invoiceResult = await _assetRepository.getUrl(
        assetDetailEntity.invoicePath!,
      );

      if (invoiceResult.isLeft()) {
        return Left(invoiceResult.swap().getOrElse(() => throw Exception()));
      }

      invoiceUrl = invoiceResult.getOrElse(() => throw Exception());
    }

    return Right(
      AssetDetailResult(
        assetDetailEntity: assetDetailEntity,
        childsEntity: childsEntity,
        imageUrl: imageUrl,
        invoiceUrl: invoiceUrl,
      ),
    );
  }
}
