import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/asset_category/domain/entities/add_category_entity.dart';
import 'package:assetmanagement/features/asset_category/domain/entities/category_detail_entity.dart';
import 'package:assetmanagement/features/asset_category/domain/entities/edit_category_entity.dart';
import 'package:assetmanagement/features/asset_category/domain/repositories/repo.dart';
import 'package:assetmanagement/features/asset_category/domain/usecases/add_category.dart';
import 'package:assetmanagement/features/asset_category/domain/usecases/add_recent_category_selections.dart';
import 'package:assetmanagement/features/asset_category/domain/usecases/delete_category.dart';
import 'package:assetmanagement/features/asset_category/domain/usecases/edit_category.dart';
import 'package:assetmanagement/features/asset_category/domain/usecases/get_category.dart';
import 'package:assetmanagement/features/asset_category/domain/usecases/get_recent_category_selection.dart';
import 'package:assetmanagement/features/asset_category/domain/usecases/search_categories.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'asset_category_event.dart';
part 'asset_category_state.dart';

class AssetCategoryBloc extends Bloc<AssetCategoryEvent, AssetCategoryState> {
  late final CategoryRepo _categoryRepo;
  late final SearchCategoriesUsecase _searchCategoriesUsecase;
  late final GetCategoryUsecase _getCategoryUsecase;
  late final AddCategoryUsecase _addCategoryUsecase;
  late final EditCategoryUsecase _editCategoryUsecase;
  late final DeleteCategoryUsecase _deleteCategoryUsecase;
  late final GetRecentCategorySelectionsUsecase
  _getRecentCategorySelectionsUsecase;
  late final AddRecentCategorySelectionUsecase
  _addRecentCategorySelectionUsecase;
  AssetCategoryBloc({
    required CategoryRepo categoryRepo,
    required SearchCategoriesUsecase searchCategoriesUsecase,
    required GetCategoryUsecase getCategoryUsecase,
    required AddCategoryUsecase addCategoryUsecase,
    required EditCategoryUsecase editCategoryUsecase,
    required DeleteCategoryUsecase deleteCategoryUsecase,
    required GetRecentCategorySelectionsUsecase
    getRecentCategorySelectionsUsecase,
    required AddRecentCategorySelectionUsecase
    addRecentCategorySelectionUsecase,
  }) : super(AssetCategoryState()) {
    _categoryRepo = categoryRepo;
    _deleteCategoryUsecase = deleteCategoryUsecase;

    //TODO: create test
    on<GetCategoriesEvent>((event, emit) async {
      emit(state.copyWith(status: CategoryStatus.loading));
      final result = await _getCategoryUsecase(id: event.id);

      result.fold(
        (failure) => emit(state.copyWith(failure: failure)),
        (r) => emit(
          state.copyWith(
            categoriesEntity: [r],
            status: CategoryStatus.getSuccess,
          ),
        ),
      );
    });
    on<SearchCategoriesEvent>((event, emit) async {
      emit(state.copyWith(status: CategoryStatus.loading));
      final result = await _searchCategoriesUsecase(value: event.value);

      result.fold(
        (failure) => emit(state.copyWith(failure: failure)),
        (r) => emit(
          state.copyWith(
            categoriesEntity: r,
            status: CategoryStatus.getSuccess,
          ),
        ),
      );
    });

    //TODO: create test

    on<AddCategoryEvent>((event, emit) async {
      emit(state.copyWith(status: CategoryStatus.loading));
      final result = await _addCategoryUsecase(category: event.categoryEntity);

      result.fold((failure) => emit(state.copyWith(failure: failure)), (r) {
        emit(state.copyWith(status: CategoryStatus.addSuccess));
      });
    });

    on<EditCategoryEvent>((event, emit) async {
      emit(state.copyWith(status: CategoryStatus.loading));
      final result = await _editCategoryUsecase(category: event.categoryEntity);

      result.fold((failure) => emit(state.copyWith(failure: failure)), (r) {
        emit(state.copyWith(status: CategoryStatus.editSucces));
      });
    });

    on<DeleteCategoryEvent>((event, emit) async {
      emit(state.copyWith(status: CategoryStatus.loading));
      final result = await _deleteCategoryUsecase(id: event.id);

      result.fold(
        (failure) => emit(
          state.copyWith(failure: failure, status: CategoryStatus.failure),
        ),
        (r) {
          emit(state.copyWith(status: CategoryStatus.deleteSuccses));
        },
      );
    });

    on<GetRecentCategorySelectionsEvent>((event, emit) async {
      emit(state.copyWith(status: CategoryStatus.loading));
      final result = await _getRecentCategorySelectionsUsecase();

      result.fold(
        (failure) => emit(
          state.copyWith(failure: failure, status: CategoryStatus.failure),
        ),
        (r) => emit(state.copyWith()),
      );
    });

    //RecentCategorySelectionEvent
    on<AddRecentCategorySelectionEvent>((event, emit) async {
      emit(state.copyWith(status: CategoryStatus.loading));
      final result = await _addRecentCategorySelectionUsecase(
        category: event.categoryEntity,
      );

      result.fold(
        (failure) => emit(
          state.copyWith(failure: failure, status: CategoryStatus.failure),
        ),
        (r) => emit(state.copyWith(status: CategoryStatus.addRecentSuccess)),
      );
    });
  }
}
