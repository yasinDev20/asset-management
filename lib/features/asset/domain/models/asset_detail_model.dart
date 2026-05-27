

import 'package:equatable/equatable.dart';

import 'package:assetmanagement/features/asset/domain/entities/asset_detail_entity.dart';

class AssetDetail extends Equatable {
  final AssetDetailEntity assetDetailEntity;
  final String imageUrl;
  final String? invoiceUrl;

  const AssetDetail({
    required this.assetDetailEntity,
    required this.imageUrl,
    required this.invoiceUrl,
  });

  @override
  List<Object> get props => [assetDetailEntity, imageUrl, ?invoiceUrl];
}
