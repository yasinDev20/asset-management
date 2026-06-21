// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:assetmanagement/features/asset/domain/entities/asset_detail_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_ref_entity.dart';

class AssetDetailResult extends Equatable {
  final AssetDetailEntity assetDetailEntity;
  final List<AssetRefEntity> childsEntity;
  final String imageUrl;
  final String? invoiceUrl;

  const AssetDetailResult({
    required this.assetDetailEntity,
    required this.imageUrl,
    required this.invoiceUrl,
    this.childsEntity = const [],
  });

  @override
  List<Object> get props => [
    assetDetailEntity,
    childsEntity,
    imageUrl,
    ?invoiceUrl,
  ];
}
