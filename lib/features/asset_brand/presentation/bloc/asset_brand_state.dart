part of 'asset_brand_bloc.dart';

enum BrandStatus {
  initial,
  getSuccess,
  addSuccess,
  editSucces,
  deleteSuccses,
  getRecentSuccess,
  addRecentSucces,
  failure,
  loading,
}

class AssetBrandState extends Equatable {
  final BrandStatus? status;
  final List<BrandDetailEntity> brandsEntity;
  final List<BrandDetailEntity> recentBrandSelections;
  final Failure? failure;
  const AssetBrandState({
    this.status = BrandStatus.initial,
    this.brandsEntity = const [],
    this.recentBrandSelections = const [],
    this.failure,
  });

  AssetBrandState copyWith({
    List<BrandDetailEntity>? brandsEntity,
    List<BrandDetailEntity>? recentBrandSelections,
    BrandStatus? status,
    Failure? failure,
  }) {
    return AssetBrandState(
      brandsEntity: brandsEntity ?? this.brandsEntity,
      recentBrandSelections:
          recentBrandSelections ?? this.recentBrandSelections,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [
    status,
    brandsEntity,
    recentBrandSelections,
    failure,
  ];
}
