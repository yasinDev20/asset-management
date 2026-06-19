part of 'asset_bloc.dart';

abstract class AssetEvent extends Equatable {
  const AssetEvent();

  @override
  List<Object> get props => [];
}

class GetAssetsLiteEvent extends AssetEvent {
  final AssetFilterEntity? filter;
  const GetAssetsLiteEvent({this.filter});
}

class LoadMoreAssetsEvent extends AssetEvent {
  final AssetFilterEntity? filter;
  const LoadMoreAssetsEvent({this.filter});
}

class GetAssetDetailEvent extends AssetEvent {
  final String id;
  const GetAssetDetailEvent(this.id);
}

class DownloadFileEvent extends AssetEvent {
  final String url;
  const DownloadFileEvent(this.url);
}

class GetAssetRefEvent extends AssetEvent {
  final String? assetId;
  final String? qrCode;
  const GetAssetRefEvent({this.assetId, this.qrCode});
}


class EditAssetEvent extends AssetEvent {
  final EditAssetEntity originalAssetEntity;
  final EditAssetEntity editAssetEntity;

  const EditAssetEvent({
    required this.editAssetEntity,
    required this.originalAssetEntity,
  });
}

class AddAssetEvent extends AssetEvent {
  final AddAssetEntity addAssetEntity;

  const AddAssetEvent({required this.addAssetEntity});
}

class AddToTemplateEvent extends AssetEvent {
  final AssetTemplateEntity assetTemplateEntity;

  const AddToTemplateEvent({required this.assetTemplateEntity});
}

class GetTemplatesEvent extends AssetEvent {
  final String value;

  const GetTemplatesEvent({required this.value});
}

class DeleteTemplateEvent extends AssetEvent {
  final String id;

  const DeleteTemplateEvent({required this.id});
}
