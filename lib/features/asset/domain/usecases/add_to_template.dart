import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_template_entity.dart';
import 'package:assetmanagement/features/asset/domain/repositories/asset_repository.dart';
import 'package:dartz/dartz.dart';

class AddToTemplateUsecase {
  final AssetRepository _assetRepository;

  AddToTemplateUsecase(this._assetRepository);

  Future<Either<Failure, Unit>> call(AssetTemplateEntity assetTemplateEntity) async {
    return await _assetRepository.addToTemplate(assetTemplateEntity);
  }
}
