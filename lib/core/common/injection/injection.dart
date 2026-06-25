import 'package:assetmanagement/features/asset/data/datasources/local_datasource.dart';
import 'package:assetmanagement/features/asset/data/datasources/remote_datasource.dart';
import 'package:assetmanagement/features/asset/data/repositories/asset_repository_impl.dart';
import 'package:assetmanagement/features/asset/domain/repositories/asset_repository.dart';
import 'package:assetmanagement/features/asset/domain/usecases/add_asset.dart';
import 'package:assetmanagement/features/asset/domain/usecases/add_to_template.dart';
import 'package:assetmanagement/features/asset/domain/usecases/delete_template.dart';
import 'package:assetmanagement/features/asset/domain/usecases/edit_asset.dart';
import 'package:assetmanagement/features/asset/domain/usecases/get_asset_detail.dart';
import 'package:assetmanagement/features/asset/domain/usecases/get_assets_lite.dart';
import 'package:assetmanagement/features/asset/domain/usecases/get_template.dart';
import 'package:assetmanagement/features/asset/presentation/bloc/asset_bloc.dart';
import 'package:assetmanagement/features/asset_brand/data/datasources/local_datasource.dart';
import 'package:assetmanagement/features/asset_brand/data/datasources/remote_datasource.dart';
import 'package:assetmanagement/features/asset_brand/data/repositories/repo_impl.dart';
import 'package:assetmanagement/features/asset_brand/domain/repositories/repo.dart';
import 'package:assetmanagement/features/asset_brand/domain/usecases/add_brand.dart';
import 'package:assetmanagement/features/asset_brand/domain/usecases/add_recent_brand_selections.dart';
import 'package:assetmanagement/features/asset_brand/domain/usecases/edit_brand.dart';
import 'package:assetmanagement/features/asset_brand/domain/usecases/get_brand.dart';
import 'package:assetmanagement/features/asset_brand/domain/usecases/get_recent_brand_selection.dart';
import 'package:assetmanagement/features/asset_brand/domain/usecases/search_brands.dart';
import 'package:assetmanagement/features/asset_brand/presentation/bloc/asset_brand_bloc.dart';
import 'package:assetmanagement/features/asset_category/data/datasources/local_datasorce.dart';
import 'package:assetmanagement/features/asset_category/data/datasources/remote_datasource.dart';
import 'package:assetmanagement/features/asset_category/data/repositories/repo_impl.dart';
import 'package:assetmanagement/features/asset_category/domain/repositories/repo.dart';
import 'package:assetmanagement/features/asset_category/domain/usecases/add_category.dart';
import 'package:assetmanagement/features/asset_category/domain/usecases/add_recent_category_selections.dart';
import 'package:assetmanagement/features/asset_category/domain/usecases/delete_category.dart';
import 'package:assetmanagement/features/asset_category/domain/usecases/edit_category.dart';
import 'package:assetmanagement/features/asset_category/domain/usecases/get_category.dart';
import 'package:assetmanagement/features/asset_category/domain/usecases/get_recent_category_selection.dart';
import 'package:assetmanagement/features/asset_category/domain/usecases/search_categories.dart';
import 'package:assetmanagement/features/asset_category/presentation/bloc/asset_category_bloc.dart';
import 'package:assetmanagement/features/asset_location/data/datasources/local_datasource.dart';
import 'package:assetmanagement/features/asset_location/data/datasources/remote_datasource.dart';
import 'package:assetmanagement/features/asset_location/data/repositories/repo_impl.dart';
import 'package:assetmanagement/features/asset_location/domain/repositories/repo.dart';
import 'package:assetmanagement/features/asset_location/domain/usecases/add_location.dart';
import 'package:assetmanagement/features/asset_location/domain/usecases/add_recent_location_selections.dart';
import 'package:assetmanagement/features/asset_location/domain/usecases/delete_location.dart';
import 'package:assetmanagement/features/asset_location/domain/usecases/edit_location.dart';
import 'package:assetmanagement/features/asset_location/domain/usecases/get_location.dart';
import 'package:assetmanagement/features/asset_location/domain/usecases/get_recent_location_selection.dart';
import 'package:assetmanagement/features/asset_location/domain/usecases/search_location.dart';
import 'package:assetmanagement/features/asset_location/presentation/bloc/asset_location_bloc.dart';
import 'package:assetmanagement/features/authentication/domain/usecases/email_register.dart';
import 'package:assetmanagement/features/authentication/domain/usecases/forgot_password.dart';
import 'package:assetmanagement/features/authentication/data/datasources/remote_datasource.dart';
import 'package:assetmanagement/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:assetmanagement/features/authentication/domain/repositories/auth_repository.dart';
import 'package:assetmanagement/features/authentication/domain/usecases/get_user.dart';
import 'package:assetmanagement/features/authentication/domain/usecases/google_sign_in.dart';
import 'package:assetmanagement/features/authentication/domain/usecases/email_password_sign_in.dart';
import 'package:assetmanagement/features/authentication/domain/usecases/sign_out.dart';
import 'package:assetmanagement/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:assetmanagement/features/user/domain/usecases/add_user.dart';
import 'package:assetmanagement/features/user/domain/usecases/get_all_user.dart';
import 'package:assetmanagement/features/user/domain/usecases/get_user.dart';
import 'package:assetmanagement/features/user/presentation/bloc/user_bloc.dart';

import 'package:dio/dio.dart';

import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../features/asset_brand/domain/usecases/delete_brand.dart';
// import 'package:google_sign_in/google_sign_in.dart';

var myInjection =
    GetIt.instance; // merupakan tempat penampungan semua dependencies

// --- Depedency
Future<void> injectionInit() async {
  //Google SignIn
  myInjection.registerLazySingleton(() => GoogleSignIn.instance);

  // Register supabase
  myInjection.registerLazySingleton<SupabaseClient>(
    () => Supabase.instance.client,
  );
  // Register Dio
  myInjection.registerLazySingleton<Dio>(() => Dio());

  //Depedency ---

  //---Repository
  myInjection.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authRemoteDataSource: myInjection()),
  );

  myInjection.registerLazySingleton<AssetRepository>(
    () => AssetRepositoryImpl(
      assetLocalDatasource: myInjection(),
      assetRemoteDataSource: myInjection(),
      supabaseClient: myInjection(),
    ),
  );

  myInjection.registerLazySingleton<CategoryRepo>(
    () => CategoryRepoImpl(
      localDatasource: myInjection(),
      remoteDatasource: myInjection(),
    ),
  );
  myInjection.registerLazySingleton<BrandRepo>(
    () => BrandRepoImpl(
      localDatasource: myInjection(),
      remoteDatasource: myInjection(),
    ),
  );
  myInjection.registerLazySingleton<LocationRepo>(
    () => LocationRepoImpl(
      localDatasource: myInjection(),
      remoteDatasource: myInjection(),
    ),
  );
  //Repository ---

  //--- Data Source
  myInjection.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(
      googleSignInPackage: myInjection(),

      supabaseClient: myInjection(),
    ),
  );

  myInjection.registerLazySingleton<AssetLocalDataSource>(
    () => AssetLocalDatasourceImpl(),
  );

  myInjection.registerLazySingleton<AssetRemoteDataSource>(
    () => AssetRemoteDataSourceImpl(
      supabaseClient: myInjection(),
      dio: myInjection(),
    ),
  );

  myInjection.registerLazySingleton<CategoryRemoteDatasource>(
    () => CategoryRemoteDatasourceImpl(supabaseClient: myInjection()),
  );
  myInjection.registerLazySingleton<CategoryLocalDatasource>(
    () => CategoryLocalDatasourceImpl(),
  );

  myInjection.registerLazySingleton<BrandRemoteDatasource>(
    () => BrandRemoteDatasourceImpl(supabaseClient: myInjection()),
  );
  myInjection.registerLazySingleton<BrandLocalDatasource>(
    () => BrandLocalDatasourceImpl(),
  );
  myInjection.registerLazySingleton<LocationRemoteDatasource>(
    () => LocationRemoteDatasourceImpl(supabaseClient: myInjection()),
  );
  myInjection.registerLazySingleton<LocationLocalDatasource>(
    () => LocationLocalDatasourceImpl(),
  );

  // Datasoruce ---

  //--- Usecase

  // Auth Usecase
  myInjection.registerLazySingleton(
    () => EmailRegisterUsecase(myInjection()), //diisi AuthRepositoryImpl
  );
  myInjection.registerLazySingleton(
    () => EmailPasswordSignUsecase(myInjection()), //diisi AuthRepositoryImpl
  );
  myInjection.registerLazySingleton(
    () => GoogleSignInUsecase(myInjection()), //diisi AuthRepositoryImpl
  );
  myInjection.registerLazySingleton(
    () => GetUserUsecase(myInjection()), //diisi AuthRepositoryImpl
  );
  myInjection.registerLazySingleton(
    () => ForgotPasswordUsecase(myInjection()), //diisi AuthRepositoryImpl
  );
  myInjection.registerLazySingleton(
    () => SignOutUsecase(myInjection()), //diisi AuthRepositoryImpl
  );

  // Auth Usecase

  // User Usecase
  myInjection.registerLazySingleton(
    () => GetAllUserUseCase(
      userRepository: myInjection(),
    ), //diisi AuthRepositoryImpl
  );
  myInjection.registerLazySingleton(
    () => AddUserUsecase(
      userRepository: myInjection(),
    ), //diisi AuthRepositoryImpl
  );
  myInjection.registerLazySingleton(
    () => GetUserUseCase(
      userRepository: myInjection(),
    ), //diisi AuthRepositoryImpl
  );
  // User Usecase

  // Asset Usecase
  myInjection.registerLazySingleton(() => GetAssetsLiteUsecase(myInjection()));
  myInjection.registerLazySingleton(() => GetAssetDetailUsecase(myInjection()));
  myInjection.registerLazySingleton(() => AddAssetUsecase(myInjection()));
  myInjection.registerLazySingleton(() => EditAssetUsecase(myInjection()));
  myInjection.registerLazySingleton(() => AddToTemplateUsecase(myInjection()));
  myInjection.registerLazySingleton(() => GetTemplateUsecase(myInjection()));
  myInjection.registerLazySingleton(() => DeleteTemplateUsecase(myInjection()));
  // Asset Usecase

  // Category Usecase
  myInjection.registerLazySingleton(
    () => SearchCategoriesUsecase(categoryRepo: myInjection()),
  );
  myInjection.registerLazySingleton(
    () => GetCategoryUsecase(categoryRepo: myInjection()),
  );
  myInjection.registerLazySingleton(
    () => AddCategoryUsecase(categoryRepo: myInjection()),
  );
  myInjection.registerLazySingleton(
    () => EditCategoryUsecase(categoryRepo: myInjection()),
  );
  myInjection.registerLazySingleton(
    () => DeleteCategoryUsecase(categoryRepo: myInjection()),
  );
  myInjection.registerLazySingleton(
    () => GetRecentCategorySelectionsUsecase(categoryRepo: myInjection()),
  );
  myInjection.registerLazySingleton(
    () => AddRecentCategorySelectionUsecase(categoryRepo: myInjection()),
  );
  // Category Usecase

  // Brand Usecase
  myInjection.registerLazySingleton(
    () => SearchBrandsUsecase(brandRepo: myInjection()),
  );
  myInjection.registerLazySingleton(
    () => GetBrandUsecase(brandRepo: myInjection()),
  );
  myInjection.registerLazySingleton(
    () => AddBrandUsecase(brandRepo: myInjection()),
  );
  myInjection.registerLazySingleton(
    () => EditBrandUsecase(brandRepo: myInjection()),
  );
  myInjection.registerLazySingleton(
    () => DeleteBrandUsecase(brandRepo: myInjection()),
  );
  myInjection.registerLazySingleton(
    () => GetRecentBrandSelectionsUsecase(brandRepo: myInjection()),
  );
  myInjection.registerLazySingleton(
    () => AddRecentBrandSelectionUsecase(brandRepo: myInjection()),
  );
  // Brand Usecase

  // Location Usecase
  myInjection.registerLazySingleton(
    () => SearchLocationsUsecase(locationRepo: myInjection()),
  );
  myInjection.registerLazySingleton(
    () => GetLocationUsecase(locationRepo: myInjection()),
  );
  myInjection.registerLazySingleton(
    () => AddLocationUsecase(locationRepo: myInjection()),
  );
  myInjection.registerLazySingleton(
    () => EditLocationUsecase(locationRepo: myInjection()),
  );
  myInjection.registerLazySingleton(
    () => DeleteLocationUsecase(locationRepo: myInjection()),
  );
  myInjection.registerLazySingleton(
    () => GetRecentLocationSelectionsUsecase(locationRepo: myInjection()),
  );
  myInjection.registerLazySingleton(
    () => AddRecentLocationSelectionUsecase(locationRepo: myInjection()),
  );
  // Location Usecase

  //Usecase ---

  //---Bloc
  myInjection.registerFactory(
    () => AuthBloc(
      authRepository: myInjection(),
      emailRegisterUsecase: myInjection(),
      getUserUseCase: myInjection(),
      emailPasswordSignUsecase: myInjection(),
      googleSignInUsecase: myInjection(),
      forgotPasswordUseCase: myInjection(),
      signOutUsecase: myInjection(),
    ),
  ); //diisi usecase
  myInjection.registerFactory(
    () => UserBloc(
      addUserUsecase: myInjection(),

      getAllUserUseCase: myInjection(),
      getUserUseCase: myInjection(),
    ),
  ); //diisi usecase

  myInjection.registerFactory(
    () => AssetBloc(
      assetRepository: myInjection(),
      getAssetLitesUsecase: myInjection(),
      getAssetDetailUsecase: myInjection(),
      addAssetUsecase: myInjection(),
      editAssetUsecase: myInjection(),
      addToTemplateUsecase: myInjection(),
      getTemplateUsecase: myInjection(),
      deleteTemplateUsecase: myInjection(),
    ),
  );

  myInjection.registerFactory(
    () => AssetCategoryBloc(
      categoryRepo: myInjection(),
      searchCategoriesUsecase: myInjection(),
      getCategoryUsecase: myInjection(),
      addCategoryUsecase: myInjection(),
      editCategoryUsecase: myInjection(),
      deleteCategoryUsecase: myInjection(),
      getRecentCategorySelectionsUsecase: myInjection(),
      addRecentCategorySelectionUsecase: myInjection(),
    ),
  );
  myInjection.registerFactory(
    () => AssetBrandBloc(
      brandRepo: myInjection(),
      searchBrandsUsecase: myInjection(),
      getBrandUsecase: myInjection(),
      addBrandUsecase: myInjection(),
      editBrandUsecase: myInjection(),
      deleteBrandUsecase: myInjection(),
      getRecentBrandSelectionsUsecase: myInjection(),
      addRecentBrandSelectionUsecase: myInjection(),
    ),
  );
  myInjection.registerFactory(
    () => AssetLocationBloc(
      locationRepo: myInjection(),
      searchLocationsUsecase: myInjection(),
      getLocationUsecase: myInjection(),
      addLocationUsecase: myInjection(),
      editLocationUsecase: myInjection(),
      deleteLocationUsecase: myInjection(),
      getRecentLocationSelectionsUsecase: myInjection(),
      addRecentLocationSelectionUsecase: myInjection(),
    ),
  );
  //Bloc ---
}
