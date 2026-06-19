part of 'asset_location_bloc.dart';

enum LocationStatus {
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

class AssetLocationState extends Equatable {
  final LocationStatus? status;
  final List<LocationDetailEntity> locationsEntity;
  final List<LocationDetailEntity> recentLocationSelections;
  final Failure? failure;
  const AssetLocationState({
    this.status = LocationStatus.initial,
    this.locationsEntity = const [],
    this.recentLocationSelections = const [],
    this.failure,
  });

  AssetLocationState copyWith({
    List<LocationDetailEntity>? locationsEntity,
    List<LocationDetailEntity>? recentLocationSelections,
    LocationStatus? status,
    Failure? failure,
  }) {
    return AssetLocationState(
      locationsEntity: locationsEntity ?? this.locationsEntity,
      recentLocationSelections:
          recentLocationSelections ?? this.recentLocationSelections,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [
    status,
    locationsEntity,
    recentLocationSelections,
    failure,
  ];
}
