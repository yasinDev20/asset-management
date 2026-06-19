import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/asset_location/domain/entities/add_location_entity%20.dart';
import 'package:assetmanagement/features/asset_location/domain/entities/edit_location_entity.dart';
import 'package:assetmanagement/features/asset_location/domain/entities/location_detail_entity.dart';
import 'package:assetmanagement/features/asset_location/domain/repositories/repo.dart';
import 'package:assetmanagement/features/asset_location/domain/usecases/add_location.dart';
import 'package:assetmanagement/features/asset_location/domain/usecases/add_recent_location_selections.dart';
import 'package:assetmanagement/features/asset_location/domain/usecases/delete_location.dart';
import 'package:assetmanagement/features/asset_location/domain/usecases/edit_location.dart';
import 'package:assetmanagement/features/asset_location/domain/usecases/get_location.dart';
import 'package:assetmanagement/features/asset_location/domain/usecases/get_recent_location_selection.dart';
import 'package:assetmanagement/features/asset_location/domain/usecases/search_location.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'asset_location_event.dart';
part 'asset_location_state.dart';

class AssetLocationBloc extends Bloc<AssetLocationEvent, AssetLocationState> {
  late final LocationRepo _locationRepo;
  late final GetLocationUsecase _getLocationUsecase;
  late final SearchLocationsUsecase _searchLocationsUsecase;
  late final AddLocationUsecase _addLocationUsecase;
  late final EditLocationUsecase _editLocationUsecase;
  late final DeleteLocationUsecase _deleteLocationUsecase;
  late final GetRecentLocationSelectionsUsecase _getRecentLocationSelectionsUsecase;
  late final AddRecentLocationSelectionUsecase _addRecentLocationSelectionUsecase;
  AssetLocationBloc({
    required LocationRepo locationRepo,
    required GetLocationUsecase getLocationUsecase,
    required SearchLocationsUsecase searchLocationsUsecase,
    required AddLocationUsecase addLocationUsecase,
    required EditLocationUsecase editLocationUsecase,
    required DeleteLocationUsecase deleteLocationUsecase,
    required GetRecentLocationSelectionsUsecase getRecentLocationSelectionsUsecase,
    required AddRecentLocationSelectionUsecase addRecentLocationSelectionUsecase,
  }) : super(AssetLocationState()) {
    _locationRepo = locationRepo;
    _searchLocationsUsecase = searchLocationsUsecase;
    _getLocationUsecase = getLocationUsecase;
    _addLocationUsecase = addLocationUsecase;
    _editLocationUsecase = editLocationUsecase;
    _deleteLocationUsecase = deleteLocationUsecase;
    _getRecentLocationSelectionsUsecase = getRecentLocationSelectionsUsecase;
    _addRecentLocationSelectionUsecase = addRecentLocationSelectionUsecase;
    //TODO: create test
    on<SearchLocationsEvent>((event, emit) async {
      emit(state.copyWith(status: LocationStatus.loading));
      final result = await _searchLocationsUsecase(value: event.value);

      result.fold(
        (failure) => emit(state.copyWith(failure: failure)),
        (r) => emit(
          state.copyWith(locationsEntity: r, status: LocationStatus.getSuccess),
        ),
      );
    });
    on<GetLocationsEvent>((event, emit) async {
      emit(state.copyWith(status: LocationStatus.loading));
      final result = await _getLocationUsecase(id: event.id);

      result.fold(
        (failure) => emit(state.copyWith(failure: failure)),
        (r) => emit(
          state.copyWith(
            locationsEntity: [r],
            status: LocationStatus.getSuccess,
          ),
        ),
      );
    });

    //TODO: create test

    on<AddLocationEvent>((event, emit) async {
      emit(state.copyWith(status: LocationStatus.loading));
      final result = await _addLocationUsecase(
        location: event.locationEntity,
      );

      result.fold((failure) => emit(state.copyWith(failure: failure)), (r) {
        emit(state.copyWith(status: LocationStatus.addSuccess));
      });
    });

    on<EditLocationEvent>((event, emit) async {
      emit(state.copyWith(status: LocationStatus.loading));
      final result = await _editLocationUsecase(
        location: event.locationEntity,
      );

      result.fold((failure) => emit(state.copyWith(failure: failure)), (r) {
        emit(state.copyWith(status: LocationStatus.editSucces));
      });
    });

    on<DeleteLocationEvent>((event, emit) async {
      emit(state.copyWith(status: LocationStatus.loading));
      final result = await _deleteLocationUsecase(id: event.id);

      result.fold((failure) => emit(state.copyWith(failure: failure)), (r) {
        emit(state.copyWith(status: LocationStatus.deleteSuccses));
      });
    });

    on<GetRecentLocationSelectionsEvent>((event, emit) async {
      emit(state.copyWith(status: LocationStatus.loading));
      final result = await _getRecentLocationSelectionsUsecase();

      result.fold(
        (failure) => emit(
          state.copyWith(failure: failure, status: LocationStatus.failure),
        ),
        (r) => emit(state.copyWith(status: LocationStatus.getRecentSuccess)),
      );
    });

    //RecentLocationSelectionEvent
    on<AddRecentLocationSelectionEvent>((event, emit) async {
      emit(state.copyWith(status: LocationStatus.loading));
      final result = await _addRecentLocationSelectionUsecase(
        location: event.locationEntity,
      );

      result.fold(
        (failure) => emit(
          state.copyWith(failure: failure, status: LocationStatus.failure),
        ),
        (r) => emit(state.copyWith(status: LocationStatus.addRecentSuccess)),
      );
    });
  }
}
