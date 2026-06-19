import 'package:assetmanagement/features/asset/domain/repositories/asset_repository.dart';
import 'package:assetmanagement/features/asset/presentation/bloc/asset_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssetSupportBloc extends Bloc<AssetEvent, AssetState> {
  late final AssetRepository _assetRepository;

  AssetSupportBloc({required AssetRepository assetRepository})
    : super(AssetInitial()) {
    _assetRepository = assetRepository;

    //TODO: create test
    on<GetAssetRefEvent>((event, emit) async {
      emit(AssetLoadingState());
      final result = await _assetRepository.getAssetRefs(
        assetId: event.assetId,
        qrCode: event.qrCode,
      );

      result.fold(
        (l) => emit(AssetFailureState(failure: l)),
        (r) => emit(GetAssetRefSuccsessState(assetRefEntity: r)),
      );
    });

  }
}
