

import 'package:assetmanagement/features/asset/domain/entities/file_entity.dart';
import 'package:equatable/equatable.dart';

import 'package:assetmanagement/features/asset/domain/entities/asset_detail_entity.dart';

class AssetDetail extends Equatable {
  final AssetDetailEntity assetDetailEntity;
  final String imageUrl;
  final FileEntity? invoiceFile;

  const AssetDetail({
    required this.assetDetailEntity,
    required this.imageUrl,
    required this.invoiceFile,
  });

  @override
  List<Object> get props => [assetDetailEntity, imageUrl, ?invoiceFile];
}
