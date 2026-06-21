import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_filter_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_lite_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_ref_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_template_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/add_asset_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/edit_asset_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_detail_result_entity.dart';
import 'package:assetmanagement/features/asset/domain/repositories/asset_repository.dart';
import 'package:assetmanagement/features/asset/domain/usecases/add_asset.dart';
import 'package:assetmanagement/features/asset/domain/usecases/add_to_template.dart';
import 'package:assetmanagement/features/asset/domain/usecases/delete_template.dart';
import 'package:assetmanagement/features/asset/domain/usecases/edit_asset.dart';
import 'package:assetmanagement/features/asset/domain/usecases/get_asset_detail.dart';
import 'package:assetmanagement/features/asset/domain/usecases/get_assets_lite.dart';
import 'package:assetmanagement/features/asset/domain/usecases/get_template.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'asset_event.dart';
part 'asset_state.dart';

class AssetBloc extends Bloc<AssetEvent, AssetState> {
  late final AssetRepository _assetRepository;
  late final GetAssetsLiteUsecase _getAssetLitesUsecase;
  late final GetAssetDetailUsecase _getAssetDetailUsecase;
  late final AddAssetUsecase _addAssetUsecase;
  late final EditAssetUsecase _editAssetUsecase;
  late final AddToTemplateUsecase _addToTemplateUsecase;
  late final GetTemplateUsecase _getTemplateUsecase;
  late final DeleteTemplateUsecase _deleteTemplateUsecase;
  static const _pageSize = 20;

  AssetBloc({
    required AssetRepository assetRepository,
    required GetAssetsLiteUsecase getAssetLitesUsecase,
    required GetAssetDetailUsecase getAssetDetailUsecase,
    required AddAssetUsecase addAssetUsecase,
    required EditAssetUsecase editAssetUsecase,
    required AddToTemplateUsecase addToTemplateUsecase,
    required GetTemplateUsecase getTemplateUsecase,
    required DeleteTemplateUsecase deleteTemplateUsecase,
  }) : super(AssetState()) {
    _getAssetLitesUsecase = getAssetLitesUsecase;

    _getAssetDetailUsecase = getAssetDetailUsecase;
    _addAssetUsecase = addAssetUsecase;
    _editAssetUsecase = editAssetUsecase;
    _addToTemplateUsecase = addToTemplateUsecase;
    _getTemplateUsecase = getTemplateUsecase;
    _deleteTemplateUsecase = deleteTemplateUsecase;
    _assetRepository = assetRepository;

    on<GetAssetDetailEvent>((event, emit) async {
      emit(state.copyWith(status: AssetStatus.loading));

      final result = await _getAssetDetailUsecase(event.id);
      result.fold(
        (failure) =>
            emit(state.copyWith(failure: failure, status: AssetStatus.failure)),
        (r) => emit(
          state.copyWith(
            assetDetailResult: r,
            status: AssetStatus.getAssetDetailSuccess,
          ),
        ),
      );
    });

    on<AddAssetEvent>((event, emit) async {
      emit(state.copyWith(status: AssetStatus.loading));

      final result = await _addAssetUsecase(event.addAssetEntity);

      result.fold(
        (failure) =>
            emit(state.copyWith(failure: failure, status: AssetStatus.failure)),
        (r) => emit(state.copyWith(status: AssetStatus.addAssetSuccess)),
      );
    });
    on<EditAssetEvent>((event, emit) async {
      emit(state.copyWith(status: AssetStatus.loading));

      final result = await _editAssetUsecase(
        originalAssetEntity: event.originalAssetEntity,
        editAssetEntity: event.editAssetEntity,
      );

      result.fold(
        (failure) =>
            emit(state.copyWith(failure: failure, status: AssetStatus.failure)),
        (r) {
          add(GetAssetsLiteEvent());
          emit(state.copyWith(status: AssetStatus.editSucces));
        },
      );
    });

    on<GetAssetsLiteEvent>((event, emit) async {
      emit(state.copyWith(status: AssetStatus.loading));
      final result = await _getAssetLitesUsecase.call(
        event.filter,
        page: 0,
        pageSize: _pageSize,
      );

      result.fold(
        (failure) =>
            emit(state.copyWith(failure: failure, status: AssetStatus.failure)),
        (r) => emit(
          state.copyWith(
            status: AssetStatus.getAssetsLiteSuccess,
            assetsLite: r,
            hasReachedMax: r.length < _pageSize,
          ),
        ),
      );
    });

    on<LoadMoreAssetsEvent>((event, emit) async {
      final current = state;
      if (current.status == AssetStatus.getAssetsLiteSuccess) return;
      if (current.hasReachedMax) return;
      emit(
        state.copyWith(
          status: AssetStatus.loadingMoreState,
          assetsLite: current.assetsLite,
        ),
      );

      final nextPage = current.assetsLite.length ~/ _pageSize;
      final result = await _getAssetLitesUsecase.call(
        event.filter,
        page: nextPage,
        pageSize: _pageSize,
      );

      result.fold(
        (failure) =>
            emit(state.copyWith(failure: failure, status: AssetStatus.failure)),
        (r) => emit(
          current.copyWith(
            assetsLite: [...current.assetsLite, ...r],
            hasReachedMax: r.length < _pageSize,
          ),
        ),
      );
    });

    on<GetAssetRefEvent>((event, emit) async {
      emit(state.copyWith(status: AssetStatus.loading));

      final result = await _assetRepository.getAssetRefs(
        assetId: event.assetId,
        qrCode: event.qrCode,
      );

      result.fold(
        (failure) =>
            emit(state.copyWith(failure: failure, status: AssetStatus.failure)),
        (r) => emit(
          state.copyWith(assetsRef: r, status: AssetStatus.getAssetRefSuccess),
        ),
      );
    });

    on<AddToTemplateEvent>((event, emit) async {
      emit(state.copyWith(status: AssetStatus.loading));

      final result = await _addToTemplateUsecase(event.assetTemplateEntity);

      result.fold(
        (failure) =>
            emit(state.copyWith(failure: failure, status: AssetStatus.failure)),
        (r) => emit(state.copyWith(status: AssetStatus.addTemplateSuccess)),
      );
    });
    on<GetTemplatesEvent>((event, emit) async {
      emit(state.copyWith(status: AssetStatus.loading));

      final result = await _getTemplateUsecase(event.value);

      result.fold(
        (failure) =>
            emit(state.copyWith(failure: failure, status: AssetStatus.failure)),
        (r) => emit(state.copyWith(assetTemplates: r, status: AssetStatus.getTemplatesSuccess)),
      );
    });

    on<DeleteTemplateEvent>((event, emit) async {
      emit(state.copyWith(status: AssetStatus.loading));

      final result = await _deleteTemplateUsecase(event.id);

      result.fold(
        (failure) =>
            emit(state.copyWith(failure: failure, status: AssetStatus.failure)),
        (r) => emit(state.copyWith(status: AssetStatus.deleteTemplateSuccses)),
      );
    });
  }
}
