import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_filter_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_lite_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_ref_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/asset_template_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/brand_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/category_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/add_asset_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/edit_asset_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/file_entity.dart';
import 'package:assetmanagement/features/asset/domain/entities/location_entity.dart';
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
  late final GetAssetDetailUsecase _getAssetDetailUsecase;
  late final AddAssetUsecase _addAssetUsecase;
  late final EditAssetUsecase _editAssetUsecase;
  late final AddToTemplateUsecase _addToTemplateUsecase;
  late final GetTemplateUsecase _getTemplateUsecase;
  late final DeleteTemplateUsecase _deleteTemplateUsecase;

 
  AssetBloc({
    required AssetRepository assetRepository,
    required GetAssetDetailUsecase getAssetDetailUsecase,
    required AddAssetUsecase addAssetUsecase,
    required EditAssetUsecase editAssetUsecase,
    required AddToTemplateUsecase addToTemplateUsecase,
    required GetTemplateUsecase getTemplateUsecase,
    required DeleteTemplateUsecase deleteTemplateUsecase,
  }) : super(AssetInitial()) {
  
   
    _getAssetDetailUsecase = getAssetDetailUsecase;
    _addAssetUsecase = addAssetUsecase;
    _editAssetUsecase = editAssetUsecase;
    _addToTemplateUsecase = addToTemplateUsecase;
    _getTemplateUsecase = getTemplateUsecase;
    _deleteTemplateUsecase = deleteTemplateUsecase;

    
    on<GetAssetDetailEvent>((event, emit) async {
      emit(AssetLoadingState());

      final result = await _getAssetDetailUsecase(event.id);
      result.fold(
        (failure) => emit(AssetFailureState(failure: failure)),
        (assetDetailModel) =>
            emit(GetAssetDetailSuccsessState(assetDetail: assetDetailModel)),
      );
    });

   


    on<AddAssetEvent>((event, emit) async {
      emit(AssetLoadingState());
      final result = await _addAssetUsecase(event.addAssetEntity);

      result.fold(
        (l) => emit(AssetFailureState(failure: l)),
        (r) =>
            emit(AddAssetSuccessState(message: 'Berhasil menambahkan asset')),
      );
    });
    on<EditAssetEvent>((event, emit) async {
      emit(AssetLoadingState());
      final result = await _editAssetUsecase(
        originalAssetEntity: event.originalAssetEntity,
        editAssetEntity: event.editAssetEntity,
      );

      result.fold((l) => emit(AssetFailureState(failure: l)), (r) {
        add(GetAssetDetailEvent(event.editAssetEntity.id));
        emit(EditAssetSuccessState(message: 'Berhasil mengedit asset'));
      });
    });
    on<AddToTemplateEvent>((event, emit) async {
      emit(AssetLoadingState());
      final result = await _addToTemplateUsecase(event.assetTemplateEntity);

      result.fold(
        (l) => emit(AssetFailureState(failure: l)),
        (r) => emit(
          AddToTemplateSuccessState(message: 'Berhasil menambahkan template'),
        ),
      );
    });
    on<GetTemplatesEvent>((event, emit) async {
      emit(AssetLoadingState());
      final result = await _getTemplateUsecase(event.value);

      result.fold(
        (l) => emit(AssetFailureState(failure: l)),
        (r) => emit(GetTemplatesSuccsessState(assetTemplateEntity: r)),
      );
    });

    on<DeleteTemplateEvent>((event, emit) async {
      emit(AssetLoadingState());
      final result = await _deleteTemplateUsecase(event.id);

      result.fold(
        (l) => emit(AssetFailureState(failure: l)),
        (r) => emit(DeleteTemplatesSuccsessState()),
      );
    });
  }
}
