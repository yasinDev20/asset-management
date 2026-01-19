part of 'asset_bloc.dart';

abstract class AssetState extends Equatable {
  const AssetState();

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

class GetAssetsSuccsessState extends AssetState {
  final List<AssetSummaryEntity> allAsset;

  const GetAssetsSuccsessState({required this.allAsset});
}
