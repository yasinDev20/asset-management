part of 'asset_brand_bloc.dart';

abstract class AssetBrandEvent extends Equatable {
  const AssetBrandEvent();
}

class SearchBrandsEvent extends AssetBrandEvent {
  final String value;
  const SearchBrandsEvent(this.value);
  @override
  List<Object> get props => [value];
}
class GetBrandsEvent extends AssetBrandEvent {
  final String id;
  const GetBrandsEvent(this.id);
  @override
  List<Object> get props => [id];
}

class AddBrandEvent extends AssetBrandEvent {
  final AddBrandEntity brandEntity;
  const AddBrandEvent(this.brandEntity);
  @override
  List<Object> get props => [brandEntity];
}

class EditBrandEvent extends AssetBrandEvent {
  final EditBrandEntity brandEntity;

  const EditBrandEvent({required this.brandEntity});
  @override
  List<Object> get props => [brandEntity];
}

class DeleteBrandEvent extends AssetBrandEvent {
  final String id;

  const DeleteBrandEvent({required this.id});
  @override
  List<Object> get props => [id];
}

class AddRecentBrandSelectionEvent extends AssetBrandEvent {
  final BrandDetailEntity brandEntity;
  const AddRecentBrandSelectionEvent({required this.brandEntity});
  @override
  List<Object> get props => [brandEntity];
}

class GetRecentBrandSelectionsEvent extends AssetBrandEvent {
  const GetRecentBrandSelectionsEvent();
  @override
  List<Object> get props => [];
}
