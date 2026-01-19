import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_summary_entity.dart';
import 'package:assetmanagement/features/asset/domain/usecases/get_assets.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'asset_event.dart';
part 'asset_state.dart';

class AssetBloc extends Bloc<AssetEvent, AssetState> {
  late final GetAssetsUsecase _getAssetsUsecase;
  AssetBloc({required GetAssetsUsecase getAssetsUsecase})
    : super(AssetInitial()) {
    _getAssetsUsecase = getAssetsUsecase;
    on<GetAssetsEvent>((event, emit) async {
      emit(AssetLoadingState());
      final result = await _getAssetsUsecase.call(event.filter);

      result.fold(
        (l) => emit(AssetFailureState(failure: l)),
        (r) => emit(GetAssetsSuccsessState(allAsset: r)),
      );
    });
  }
}
