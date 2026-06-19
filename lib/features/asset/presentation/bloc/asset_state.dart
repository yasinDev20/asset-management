part of 'asset_bloc.dart';

abstract class AssetState extends Equatable {
  const AssetState();

  @override
  List<Object> get props => [];
}

abstract class AssetSuccesState extends AssetState implements Equatable {
  final String message;

  const AssetSuccesState({required this.message});

  @override
  List<Object> get props => [];
}

class AssetInitial extends AssetState {}

class AssetLoadingState extends AssetState {}

class AssetFailureState extends AssetState {
  final Failure failure;

  const AssetFailureState({required this.failure});
  String get message => '[${failure.code}] ${failure.message}';

  @override
  List<Object> get props => [failure];
}

class GetAssetRefSuccsessState extends AssetState {
  final List<AssetRefEntity> assetRefEntity;

  const GetAssetRefSuccsessState({required this.assetRefEntity});
}

class GetAssetsLiteSuccessState extends AssetState {
  final List<AssetLiteEntity> assets;
  final bool hasReachedMax;

  const GetAssetsLiteSuccessState({
    required this.assets,
    required this.hasReachedMax,
  });

  GetAssetsLiteSuccessState copyWith({
    List<AssetLiteEntity>? assets,
    bool? hasReachedMax,
  }) => GetAssetsLiteSuccessState(
    assets: assets ?? this.assets,
    hasReachedMax: hasReachedMax ?? this.hasReachedMax,
  );
}

class AssetLoadingMoreState extends AssetState {
  final List<AssetLiteEntity> currentAssets;
  const AssetLoadingMoreState({required this.currentAssets});
}

class GetAssetDetailSuccsessState extends AssetState {
  final AssetDetailResult assetDetail;

  const GetAssetDetailSuccsessState({required this.assetDetail});
}

class DownloadFileSuccessState extends AssetState {
  final FileEntity file;

  const DownloadFileSuccessState({required this.file});
}

class AddAssetSuccessState extends AssetState {
  final String message;
  const AddAssetSuccessState({required this.message});
}

class EditAssetSuccessState extends AssetState {
  final String message;
  const EditAssetSuccessState({required this.message});
}

class AddToTemplateSuccessState extends AssetState {
  final String message;
  const AddToTemplateSuccessState({required this.message});
}

class DeleteTemplatesSuccsessState extends AssetState {
  final String message = 'Berhasil menghapus template';
  const DeleteTemplatesSuccsessState();
}

class GetTemplatesSuccsessState extends AssetState {
  final List<AssetTemplateEntity> assetTemplateEntity;
  const GetTemplatesSuccsessState({required this.assetTemplateEntity});
}
