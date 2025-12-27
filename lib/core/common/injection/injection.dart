import 'package:assetmanagement/features/authentication/domain/usecases/email_register.dart';
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
import 'package:assetmanagement/features/user/domain/usecases/forgot_password.dart';
import 'package:assetmanagement/features/user/domain/usecases/get_all_user.dart';
import 'package:assetmanagement/features/user/domain/usecases/get_user.dart';
import 'package:assetmanagement/features/user/presentation/bloc/user_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
      signOutUsecase: myInjection(),
    ),
  ); //diisi usecase
  myInjection.registerFactory(
    () => UserBloc(
      addUserUsecase: myInjection(),
      forgotPasswordUseCase: myInjection(),
      getAllUserUseCase: myInjection(),
      getUserUseCase: myInjection(),
    ),
  ); //diisi usecase

  //Usecase
  //Auth Feature Usecase
  myInjection.registerLazySingleton(
    () => EmailRegisterUsecase(myInjection()), //diisi AuthRepositoryImpl
  );
  myInjection.registerLazySingleton(
    () => EmailPasswordSignUsecase(
      authRepository: myInjection(),
    ), //diisi AuthRepositoryImpl
  );
  myInjection.registerLazySingleton(
    () => GoogleSignInUsecase(
      authRepository: myInjection(),
    ), //diisi AuthRepositoryImpl
  );
  myInjection.registerLazySingleton(
    () => GetUserUsecase(
      authRepository: myInjection(),
    ), //diisi AuthRepositoryImpl
  );
  myInjection.registerLazySingleton(
    () => SignOutUsecase(
      authRepository: myInjection(),
    ), //diisi AuthRepositoryImpl
  );

  //User Feature Usecase
  myInjection.registerLazySingleton(
    () => ForgotPasswordUseCase(
      userRepository: myInjection(),
    ), //diisi AuthRepositoryImpl
  );
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
    ), //diisi AuthRemoteDatasourceImpl()
  );

  //Data Source
  // myInjection.registerLazySingleton<ProfileRemoteDataSource>(() => ProfileRemoteDataSourcesImplementation(client: myInjection()));
  myInjection.registerLazySingleton<AuthRemoteDatasource>(
    () => AuthRemoteDatasourceImpl(
      isWeb: kIsWeb,
      googleSignInPackage: myInjection(),
      googleAuthProvider: myInjection(),
      firebaseAuth: myInjection(),
      firestore: myInjection(),
    ),
  );
}
