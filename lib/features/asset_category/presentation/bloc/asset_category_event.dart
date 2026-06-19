part of 'asset_category_bloc.dart';

abstract class AssetCategoryEvent extends Equatable {
  const AssetCategoryEvent();
}

class GetCategoriesEvent extends AssetCategoryEvent {
  final String id;
  const GetCategoriesEvent(this.id);

  @override
  List<Object?> get props => [id];
}
class SearchCategoriesEvent extends AssetCategoryEvent {
  final String value;
  const SearchCategoriesEvent(this.value);

  @override
  List<Object?> get props => [value];
}

class AddCategoryEvent extends AssetCategoryEvent {
  final AddCategoryEntity categoryEntity;
  const AddCategoryEvent({required this.categoryEntity});

  @override
  List<Object?> get props => [categoryEntity];
}

class EditCategoryEvent extends AssetCategoryEvent {
  final EditCategoryEntity categoryEntity;
  const EditCategoryEvent({required this.categoryEntity});
  @override
  List<Object?> get props => [categoryEntity];
}

class DeleteCategoryEvent extends AssetCategoryEvent {
  final String id;

  const DeleteCategoryEvent({required this.id});
  @override
  List<Object?> get props => [id];
}

class GetRecentCategorySelectionsEvent extends AssetCategoryEvent {
  const GetRecentCategorySelectionsEvent();
  @override
  List<Object?> get props => [];
}

class AddRecentCategorySelectionEvent extends AssetCategoryEvent {
  final CategoryDetailEntity categoryEntity;
  const AddRecentCategorySelectionEvent({required this.categoryEntity});

  @override
  List<Object?> get props => [categoryEntity];
}
