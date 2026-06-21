// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'asset_bloc.dart';

enum AssetStatus {
  initial,
  getAssetDetailSuccess,
  getAssetsLiteSuccess,
  getAssetRefSuccess,
  getTemplatesSuccess,
  addAssetSuccess,
  addTemplateSuccess,
  editSucces,
  deleteAssetSuccses,
  deleteTemplateSuccses,
  loadMoreState,
  loadingMoreState,
  failure,
  loading,
}

class AssetState extends Equatable {
  final AssetStatus? status;
  final AssetDetailResult? assetDetailResult;
  final List<AssetLiteEntity> assetsLite;
  final bool hasReachedMax;
  final List<AssetRefEntity> assetsRef;
  final List<AssetTemplateEntity> assetTemplates;
  final Failure? failure;
  const AssetState({
    this.status = AssetStatus.initial,
    this.assetsLite = const [],
    this.failure,
    this.assetsRef = const [],
    this.assetDetailResult,
    this.hasReachedMax = false,
    this.assetTemplates = const [],
  });

  @override
  List<Object?> get props => [status, assetsLite, failure];

  AssetState copyWith({
    AssetStatus? status,
    AssetDetailResult? assetDetailResult,
    List<AssetLiteEntity>? assetsLite,
    bool? hasReachedMax,
    List<AssetRefEntity>? assetsRef,
    List<AssetTemplateEntity>? assetTemplates,
    Failure? failure,
  }) {
    return AssetState(
      status: status ?? this.status,
      assetDetailResult: assetDetailResult ?? this.assetDetailResult,
      assetsLite: assetsLite ?? this.assetsLite,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      assetsRef: assetsRef ?? this.assetsRef,
      assetTemplates: assetTemplates ?? this.assetTemplates,
      failure: failure ?? this.failure,
    );
  }
}

