import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_template_entity.dart';
import 'package:assetmanagement/features/asset/domain/repositories/asset_repository.dart';
import 'package:dartz/dartz.dart';

class GetTemplateUsecase {
  final AssetRepository _assetRepository;

  GetTemplateUsecase(this._assetRepository);

  Future<Either<Failure, List<AssetTemplateEntity>>> call(String search) async {
    return await _assetRepository.getTemplate(search);
  }
  
}
