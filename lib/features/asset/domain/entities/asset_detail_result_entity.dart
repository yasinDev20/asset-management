

import 'package:equatable/equatable.dart';

import 'package:assetmanagement/features/asset/domain/entities/asset_detail_entity.dart';

class AssetDetailResult extends Equatable {
  final AssetDetailEntity assetDetailEntity;
  final String imageUrl;
  final String? invoiceUrl;

  const AssetDetailResult({
    required this.assetDetailEntity,
    required this.imageUrl,
    required this.invoiceUrl,
  });

  @override
  List<Object> get props => [assetDetailEntity, imageUrl, ?invoiceUrl];
}
