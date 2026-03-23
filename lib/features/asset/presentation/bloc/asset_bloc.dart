import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_lite_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_ref_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/brand_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/category_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/file_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/location_entity.dart';
import 'package:assetmanagement/features/asset/domain/models/asset_detail_model.dart';
import 'package:assetmanagement/features/asset/domain/repositories/asset_repository.dart';
import 'package:assetmanagement/features/asset/domain/usecases/get_asset_detail.dart';
import 'package:assetmanagement/features/asset/domain/usecases/get_assets_lite.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'asset_event.dart';
part 'asset_state.dart';

class AssetBloc extends Bloc<AssetEvent, AssetState> {
  late final GetAssetsLiteUsecase _getAssetsUsecase;
  late final GetAssetDetailUsecase _getAssetDetailUsecase;
  late final AssetRepository _assetRepository;
  AssetBloc({
    required AssetRepository assetRepository,
    required GetAssetsLiteUsecase getAssetsUsecase,
    required GetAssetDetailUsecase getAssetDetailUsecase,
  }) : super(AssetInitial()) {
    _assetRepository = assetRepository;
    _getAssetsUsecase = getAssetsUsecase;
    _getAssetDetailUsecase = getAssetDetailUsecase;

    on<GetAssetsLiteEvent>((event, emit) async {
      emit(AssetLoadingState());
      final result = await _getAssetsUsecase.call(event.filter);

      result.fold(
        (l) => emit(AssetFailureState(failure: l)),
        (r) => emit(GetAssetsLiteSuccsessState(allAsset: r)),
      );
    });

    on<GetAssetDetailEvent>((event, emit) async {
      emit(AssetLoadingState());

      final result = await _getAssetDetailUsecase(event.id);
      result.fold(
        (failure) => emit(AssetFailureState(failure: failure)),
        (assetDetailModel) =>
            emit(GetAssetDetailSuccsessState(assetDetail: assetDetailModel)),
      );
    });

    //TODO: create test
    on<GetAssetRefEvent>((event, emit) async {
      emit(AssetLoadingState());
      final result = await _assetRepository.getAssetRefs(
        ids: event.ids,
        qrCodes: event.qrCodes,
      );

      result.fold(
        (l) => emit(AssetFailureState(failure: l)),
        (r) => emit(GetAssetRefSuccsessState(assetRefEntity: r)),
      );
    });

    //TODO: create test
    on<GetBrandsEvent>((event, emit) async {
      emit(AssetLoadingState());
      final result = await _assetRepository.getBrands(event.value);

      result.fold(
        (l) => emit(AssetFailureState(failure: l)),
        (r) => emit(GetBrandsSuccsessState(brandsEntity: r)),
      );
    });

    on<AddBrandEvent>((event, emit) async {
      emit(AssetLoadingState());
      final result = await _assetRepository.addBrand(
        name: event.name,
        ownerId: '550e8400-e29b-41d4-a716-446655440000',
      );

      result.fold((l) => emit(AssetFailureState(failure: l)), (r) {
        emit(AddBrandSuccsessState(message: 'Merek berhasil ditambahkan'));
        add(GetBrandsEvent(event.name));
      });
    });
    //TODO: create test
    on<GetCategoriesEvent>((event, emit) async {
      emit(AssetLoadingState());
      final result = await _assetRepository.getCategories(event.value);

      result.fold(
        (l) => emit(AssetFailureState(failure: l)),
        (r) => emit(GetCategoriesSuccsessState(categoriesEntity: r)),
      );
    });
    //TODO: create test

    on<AddCategoryEvent>((event, emit) async {
      emit(AssetLoadingState());
      final result = await _assetRepository.addCategory(
        name: event.name,
        code: event.code,
        ownerId: '550e8400-e29b-41d4-a716-446655440000',
      );

      result.fold((l) => emit(AssetFailureState(failure: l)), (r) {
        emit(
          AddCategorySuccsessState(message: 'Kategori berhasil ditambahkan'),
        );

        add(GetCategoriesEvent(event.name));
      });
    });
    //TODO: create test
    on<GetLocationsEvent>((event, emit) async {
      emit(AssetLoadingState());
      final result = await _assetRepository.getLocations(event.value);

      result.fold(
        (l) => emit(AssetFailureState(failure: l)),
        (r) => emit(GetLocationsSuccsessState(locationsEntity: r)),
      );
    });
    //TODO: create test

    on<AddLocationEvent>((event, emit) async {
      emit(AssetLoadingState());
      final result = await _assetRepository.addLocation(
        name: event.name,
        ownerId: '550e8400-e29b-41d4-a716-446655440000',
      );

      result.fold((l) => emit(AssetFailureState(failure: l)), (r) {
        emit(AddLocationSuccsessState(message: 'Lokasi berhasil ditambahkan'));
        add(GetLocationsEvent(event.name));
      });
    });

    //RecentBrandSelectionEvent
    on<AddRecentBrandSelectionEvent>((event, emit) async {
      emit(AssetLoadingState());
      final result = await _assetRepository.addRecentBrandSelection(
        event.brandEntity,
      );

      result.fold(
        (l) => emit(AssetFailureState(failure: l)),
        (r) => emit(AddRecentBrandSelectionSuccessState()),
      );
    });
    on<GetRecentBrandSelectionsEvent>((event, emit) async {
      emit(AssetLoadingState());
      final result = await _assetRepository.getRecentBrandSelections();

      result.fold(
        (l) => emit(AssetFailureState(failure: l)),
        (r) => emit(GetRecentBrandSelectionsSuccessState(brandsEntity: r)),
      );
    });
    //RecentCategorySelectionEvent
    on<AddRecentCategorySelectionEvent>((event, emit) async {
      emit(AssetLoadingState());
      final result = await _assetRepository.addRecentCategorySelection(
        event.categoryEntity,
      );

      result.fold(
        (l) => emit(AssetFailureState(failure: l)),
        (r) => emit(AddRecentCategorySelectionSuccessState()),
      );
    });
    on<GetRecentCategorySelectionsEvent>((event, emit) async {
      emit(AssetLoadingState());
      final result = await _assetRepository.getRecentCategorySelections();

      result.fold(
        (l) => emit(AssetFailureState(failure: l)),
        (r) =>
            emit(GetRecentCategorySelectionsSuccessState(categoriesEntity: r)),
      );
    });
    //RecentLocationSelectionEvent
    on<AddRecentLocationSelectionEvent>((event, emit) async {
      emit(AssetLoadingState());
      final result = await _assetRepository.addRecentLocationSelection(
        event.locationEntity,
      );

      result.fold(
        (l) => emit(AssetFailureState(failure: l)),
        (r) => emit(AddRecentLocationSelectionSuccessState()),
      );
    });
    on<GetRecentLocationSelectionsEvent>((event, emit) async {
      emit(AssetLoadingState());
      final result = await _assetRepository.getRecentLocationSelections();

      result.fold(
        (l) => emit(AssetFailureState(failure: l)),
        (r) =>
            emit(GetRecentLocationSelectionsSuccessState(locationsEntity: r)),
      );
    });
  }
}
