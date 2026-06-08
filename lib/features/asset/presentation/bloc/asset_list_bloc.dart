import 'package:assetmanagement/features/asset/domain/usecases/get_assets_lite.dart';
import 'package:assetmanagement/features/asset/presentation/bloc/asset_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class AssetListBloc extends Bloc<AssetEvent, AssetState> {
  late final GetAssetsLiteUsecase _getAssetLitesUsecase;
  static const _pageSize = 20;
  AssetListBloc({required GetAssetsLiteUsecase getAssetsUsecase})
    : super(AssetInitial()) {
    _getAssetLitesUsecase = getAssetsUsecase;
    on<GetAssetsLiteEvent>((event, emit) async {
      emit(AssetLoadingState());
      final result = await _getAssetLitesUsecase.call(
        event.filter,
        page: 0,
        pageSize: _pageSize,
      );

      result.fold(
        (l) => emit(AssetFailureState(failure: l)),
        (r) => emit(
          GetAssetsLiteSuccessState(
            assets: r,
            hasReachedMax: r.length < _pageSize,
          ),
        ),
      );
    });

    on<LoadMoreAssetsEvent>((event, emit) async {
      final current = state;
      if (current is! GetAssetsLiteSuccessState) return;
      if (current.hasReachedMax) return;

      emit(AssetLoadingMoreState(currentAssets: current.assets));

      final nextPage = current.assets.length ~/ _pageSize;
      final result = await _getAssetLitesUsecase.call(
        event.filter,
        page: nextPage,
        pageSize: _pageSize,
      );

      result.fold(
        (l) => emit(AssetFailureState(failure: l)),
        (r) => emit(
          current.copyWith(
            assets: [...current.assets, ...r],
            hasReachedMax: r.length < _pageSize,
          ),
        ),
      );
    });
  }
}
