import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/asset_brand/domain/entities/add_brand_entity.dart';
import 'package:assetmanagement/features/asset_brand/domain/entities/brand_detail_entity.dart';
import 'package:assetmanagement/features/asset/domain/repositories/asset_repository.dart';
import 'package:assetmanagement/features/asset_brand/domain/entities/edit_brand_entity.dart';
import 'package:assetmanagement/features/asset_brand/domain/repositories/repo.dart';
import 'package:assetmanagement/features/asset_brand/domain/usecases/add_brand.dart';
import 'package:assetmanagement/features/asset_brand/domain/usecases/add_recent_brand_selections.dart';
import 'package:assetmanagement/features/asset_brand/domain/usecases/delete_brand.dart';
import 'package:assetmanagement/features/asset_brand/domain/usecases/edit_brand.dart';
import 'package:assetmanagement/features/asset_brand/domain/usecases/get_brand.dart';
import 'package:assetmanagement/features/asset_brand/domain/usecases/get_recent_brand_selection.dart';
import 'package:assetmanagement/features/asset_brand/domain/usecases/search_brands.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'asset_brand_event.dart';
part 'asset_brand_state.dart';

class AssetBrandBloc extends Bloc<AssetBrandEvent, AssetBrandState> {
  late final BrandRepo _brandRepo;
  late final GetBrandUsecase _getBrandUsecase;
  late final SearchBrandsUsecase _searchBrandsUsecase;
  late final AddBrandUsecase _addBrandUsecase;
  late final EditBrandUsecase _editBrandUsecase;
  late final DeleteBrandUsecase _deleteBrandUsecase;
  late final GetRecentBrandSelectionsUsecase _getRecentBrandSelectionsUsecase;
  late final AddRecentBrandSelectionUsecase _addRecentBrandSelectionUsecase;
  AssetBrandBloc({
    required BrandRepo brandRepo,
    required GetBrandUsecase getBrandUsecase,
    required SearchBrandsUsecase searchBrandsUsecase,
    required AddBrandUsecase addBrandUsecase,
    required EditBrandUsecase editBrandUsecase,
    required DeleteBrandUsecase deleteBrandUsecase,
    required GetRecentBrandSelectionsUsecase getRecentBrandSelectionsUsecase,
    required AddRecentBrandSelectionUsecase addRecentBrandSelectionUsecase,
  }) : super(AssetBrandState()) {
    _brandRepo = brandRepo;
    _searchBrandsUsecase = searchBrandsUsecase;
    _getBrandUsecase = getBrandUsecase;
    _addBrandUsecase = addBrandUsecase;
    _editBrandUsecase = editBrandUsecase;
    _deleteBrandUsecase = deleteBrandUsecase;
    _getRecentBrandSelectionsUsecase = getRecentBrandSelectionsUsecase;
    _addRecentBrandSelectionUsecase = addRecentBrandSelectionUsecase;
    //TODO: create test
    on<SearchBrandsEvent>((event, emit) async {
      emit(state.copyWith(status: BrandStatus.loading));
      final result = await _searchBrandsUsecase(value: event.value);

      result.fold(
        (failure) =>
            emit(state.copyWith(failure: failure, status: BrandStatus.failure)),
        (r) => emit(
          state.copyWith(brandsEntity: r, status: BrandStatus.getSuccess),
        ),
      );
    });
    on<GetBrandsEvent>((event, emit) async {
      emit(state.copyWith(status: BrandStatus.loading));
      final result = await _getBrandUsecase(id: event.id);

      result.fold(
        (failure) =>
            emit(state.copyWith(failure: failure, status: BrandStatus.failure)),
        (r) => emit(
          state.copyWith(brandsEntity: [r], status: BrandStatus.getSuccess),
        ),
      );
    });

    on<AddBrandEvent>((event, emit) async {
      emit(state.copyWith(status: BrandStatus.loading));
      final result = await _addBrandUsecase(brand: event.brandEntity);

      result.fold(
        (failure) =>
            emit(state.copyWith(failure: failure, status: BrandStatus.failure)),
        (r) {
          emit(state.copyWith(status: BrandStatus.addSuccess));
        },
      );
    });
    on<EditBrandEvent>((event, emit) async {
      emit(state.copyWith(status: BrandStatus.loading));
      final result = await _editBrandUsecase(brand: event.brandEntity);

      result.fold(
        (failure) =>
            emit(state.copyWith(failure: failure, status: BrandStatus.failure)),
        (r) {
          emit(state.copyWith(status: BrandStatus.editSucces));
        },
      );
    });
    on<DeleteBrandEvent>((event, emit) async {
      emit(state.copyWith(status: BrandStatus.loading));
      final result = await _deleteBrandUsecase(id: event.id);

      result.fold(
        (failure) =>
            emit(state.copyWith(failure: failure, status: BrandStatus.failure)),
        (r) {
          emit(state.copyWith(status: BrandStatus.deleteSuccses));
        },
      );
    });

    //RecentBrandSelectionEvent
    on<AddRecentBrandSelectionEvent>((event, emit) async {
      emit(state.copyWith(status: BrandStatus.loading));
      final result = await _addRecentBrandSelectionUsecase(
        brand: event.brandEntity,
      );

      result.fold(
        (failure) =>
            emit(state.copyWith(failure: failure, status: BrandStatus.failure)),
        (r) => emit(state.copyWith(status: BrandStatus.addRecentSucces)),
      );
    });
    on<GetRecentBrandSelectionsEvent>((event, emit) async {
      emit(state.copyWith(status: BrandStatus.loading));
      final result = await _getRecentBrandSelectionsUsecase();

      result.fold(
        (failure) =>
            emit(state.copyWith(failure: failure, status: BrandStatus.failure)),
        (r) => emit(
          state.copyWith(
            recentBrandSelections: r,
            status: BrandStatus.getRecentSuccess,
          ),
        ),
      );
    });
  }
}
