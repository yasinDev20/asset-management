import 'package:assetmanagement/features/asset/data/datasources/local_datasource.dart';
import 'package:assetmanagement/features/asset/data/datasources/remote_datasource.dart';
import 'package:assetmanagement/features/asset/data/repositories/asset_repository_impl.dart';
import 'package:assetmanagement/features/asset/domain/repositories/asset_repository.dart';
import 'package:assetmanagement/features/asset/domain/usecases/get_asset_detail.dart';
import 'package:assetmanagement/features/asset/domain/usecases/get_assets_lite.dart';
import 'package:assetmanagement/features/asset/presentation/bloc/asset_bloc.dart';
import 'package:assetmanagement/features/authentication/domain/usecases/email_register.dart';
import 'package:assetmanagement/features/authentication/domain/usecases/forgot_password.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:assetmanagement/features/authentication/data/datasources/remote_datasource.dart';
import 'package:assetmanagement/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:assetmanagement/features/authentication/domain/repositories/auth_repository.dart';
import 'package:assetmanagement/features/authentication/domain/usecases/get_user.dart';
import 'package:assetmanagement/features/authentication/domain/usecases/google_sign_in.dart';
import 'package:assetmanagement/features/authentication/domain/usecases/email_password_sign_in.dart';
import 'package:assetmanagement/features/authentication/domain/usecases/sign_out.dart';
import 'package:assetmanagement/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:assetmanagement/features/authentication/presentation/bloc/auth_event_listener.dart';
import 'package:assetmanagement/features/user/data/repositories/user_repository_impl.dart';
import 'package:assetmanagement/features/user/domain/repositories/user_repository.dart';
import 'package:assetmanagement/features/user/domain/usecases/add_user.dart';
import 'package:assetmanagement/features/user/domain/usecases/get_all_user.dart';
import 'package:assetmanagement/features/user/domain/usecases/get_user.dart';
import 'package:assetmanagement/features/user/presentation/bloc/user_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:google_sign_in/google_sign_in.dart';

var myInjection =
    GetIt.instance; // merupakan tempat penampungan semua dependencies

//Kita akan men-inject semua dependencies
Future<void> injectionInit() async {
  //Google SignIn
  myInjection.registerLazySingleton(() => GoogleSignIn.instance);

  //Google Provider
  myInjection.registerLazySingleton<GoogleAuthProvider>(
    () => GoogleAuthProvider(),
  );

  // Register FirebaseAuth
  myInjection.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  // Register FirebaseFirestore
  myInjection.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );
  // Register supabase
  myInjection.registerLazySingleton<SupabaseClient>(
    () => Supabase.instance.client,
  );

  myInjection.registerLazySingleton<AuthEventListener>(
    () => AuthEventListenerImpl(),
  );

  //Bloc
  myInjection.registerFactory(
    () => AuthBloc(
      authEventListener: myInjection(),
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
      getAssetsUsecase: myInjection(),
      getAssetDetailUsecase: myInjection(),
    ),
  );

  //Usecase
  //Auth Usecase
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

  //User Usecase
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

  //Asset Usecase
  myInjection.registerLazySingleton(() => GetAssetsLiteUsecase(myInjection()));
  myInjection.registerLazySingleton(() => GetAssetDetailUsecase(myInjection()));

  //Repository
  myInjection.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDataSource: myInjection(),
    ), //diisi AuthRemoteDatasourceImpl()
  );
  myInjection.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      firebaseAuth: myInjection(),
      firebaseFirestore: myInjection(),
    ),
  );
  myInjection.registerLazySingleton<AssetRepository>(
    () => AssetRepositoryImpl(
      assetLocalDatasource: myInjection(),
      assetRemoteDataSource: myInjection(),
      supabaseClient: myInjection(),
    ),
  );

  //Data Source
  myInjection.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(
      isWeb: kIsWeb,
      googleSignInPackage: myInjection(),
      googleAuthProvider: myInjection(),
      firebaseAuth: myInjection(),
      firestore: myInjection(),
    ),
  );

  myInjection.registerLazySingleton<AssetLocalDataSource>(
    () => AssetLocalDatasourceImpl(),
  );

  myInjection.registerLazySingleton<AssetRemoteDataSource>(
    () => AssetRemoteDataSourceImpl(supabaseClient: myInjection()),
  );
}
