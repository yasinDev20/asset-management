part of 'asset_bloc.dart';

abstract class AssetEvent extends Equatable {
  const AssetEvent();

  @override
  List<Object> get props => [];
}

class GetAssetsLiteEvent extends AssetEvent {
  final List<Map<String, String>> filter;
  const GetAssetsLiteEvent(this.filter);
}

class GetAssetDetailEvent extends AssetEvent {
  final String id;
  const GetAssetDetailEvent(this.id);
}

class DownloadFileEvent extends AssetEvent {
  final String path;
  const DownloadFileEvent(this.path);
}

class GetAssetRefEvent extends AssetEvent {
  final List<String>? ids;
  final List<String>? qrCodes;
  const GetAssetRefEvent({this.ids, this.qrCodes});
}

class GetBrandsEvent extends AssetEvent {
  final String value;
  const GetBrandsEvent(this.value);
}

class AddBrandEvent extends AssetEvent {
  final String name;
  const AddBrandEvent(this.name);
}

class GetCategoriesEvent extends AssetEvent {
  final String value;
  const GetCategoriesEvent(this.value);
}

class AddCategoryEvent extends AssetEvent {
  final String name;
  final String code;
  const AddCategoryEvent({required this.code, required this.name});
}

class GetLocationsEvent extends AssetEvent {
  final String value;
  const GetLocationsEvent(this.value);
}

class AddLocationEvent extends AssetEvent {
  final String name;
  const AddLocationEvent({required this.name});
}

class AddRecentBrandSelectionEvent extends AssetEvent {
  final BrandEntity brandEntity;
  const AddRecentBrandSelectionEvent({required this.brandEntity});
}

class GetRecentBrandSelectionsEvent extends AssetEvent {
  const GetRecentBrandSelectionsEvent();
}

class AddRecentCategorySelectionEvent extends AssetEvent {
  final CategoryEntity categoryEntity;
  const AddRecentCategorySelectionEvent({required this.categoryEntity});
}

class GetRecentCategorySelectionsEvent extends AssetEvent {
  const GetRecentCategorySelectionsEvent();
}

class AddRecentLocationSelectionEvent extends AssetEvent {
  final LocationEntity locationEntity;
  const AddRecentLocationSelectionEvent({required this.locationEntity});
}

class GetRecentLocationSelectionsEvent extends AssetEvent {
  const GetRecentLocationSelectionsEvent();
}
