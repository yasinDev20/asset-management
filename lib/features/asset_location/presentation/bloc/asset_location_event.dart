part of 'asset_location_bloc.dart';

abstract class AssetLocationEvent extends Equatable {
  const AssetLocationEvent();
}

class SearchLocationsEvent extends AssetLocationEvent {
  final String value;
  const SearchLocationsEvent(this.value);

  @override
  List<Object?> get props => [value];
}

class GetLocationsEvent extends AssetLocationEvent {
  final String id;
  const GetLocationsEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class AddLocationEvent extends AssetLocationEvent {
  final AddLocationEntity locationEntity;
  const AddLocationEvent({required this.locationEntity});

  @override
  List<Object?> get props => [locationEntity];
}

class EditLocationEvent extends AssetLocationEvent {
  final EditLocationEntity locationEntity;

  const EditLocationEvent({required this.locationEntity});

  @override
  List<Object?> get props => [locationEntity];
}

class DeleteLocationEvent extends AssetLocationEvent {
  final String id;

  const DeleteLocationEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class GetRecentLocationSelectionsEvent extends AssetLocationEvent {
  const GetRecentLocationSelectionsEvent();

  @override
  List<Object?> get props => [];
}

class AddRecentLocationSelectionEvent extends AssetLocationEvent {
  final LocationDetailEntity locationEntity;
  const AddRecentLocationSelectionEvent({required this.locationEntity});

  @override
  List<Object?> get props => [locationEntity];
}
