part of 'asset_category_bloc.dart';

enum CategoryStatus {
  initial,
  getSuccess,
  getRecentSuccess,
  addRecentSuccess,
  addSuccess,
  editSucces,
  deleteSuccses,
  failure,
  loading,
}

class AssetCategoryState extends Equatable {
  final CategoryStatus? status;
  final List<CategoryDetailEntity> categoriesEntity;
  final List<CategoryDetailEntity> recentCategorySelections;
  final Failure? failure;
  const AssetCategoryState({
    this.status = CategoryStatus.initial,
    this.categoriesEntity = const [],
    this.recentCategorySelections = const [],
    this.failure,
  });

  AssetCategoryState copyWith({
    List<CategoryDetailEntity>? categoriesEntity,
    List<CategoryDetailEntity>? recentCategorySelections,
    CategoryStatus? status,
    Failure? failure,
  }) {
    return AssetCategoryState(
      categoriesEntity: categoriesEntity ?? this.categoriesEntity,
      recentCategorySelections:
          recentCategorySelections ?? this.recentCategorySelections,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [
    status,
    categoriesEntity,
    recentCategorySelections,
    failure,
  ];
}
