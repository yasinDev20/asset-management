import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/asset/domain/repositories/asset_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteTemplateUsecase {
  final AssetRepository _assetRepository;

  DeleteTemplateUsecase(this._assetRepository);

  Future<Either<Failure, Unit>> call(String id) async {
    return await _assetRepository.deleteTemplate(id);
  }
  
}