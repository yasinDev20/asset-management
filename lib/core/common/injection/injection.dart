import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:computer_lab_inventory_application/features/authentication/data/datasources/remote_datasource.dart';
import 'package:computer_lab_inventory_application/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:computer_lab_inventory_application/features/authentication/domain/repositories/auth_repository.dart';
import 'package:computer_lab_inventory_application/features/authentication/domain/usecases/get_current_user.dart';
import 'package:computer_lab_inventory_application/features/authentication/domain/usecases/sign_in_with_google.dart';
import 'package:computer_lab_inventory_application/features/authentication/domain/usecases/login.dart';
import 'package:computer_lab_inventory_application/features/authentication/domain/usecases/sign_out.dart';
import 'package:computer_lab_inventory_application/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:computer_lab_inventory_application/features/user/data/repositories/user_repository_impl.dart';
import 'package:computer_lab_inventory_application/features/user/domain/repositories/user_repository.dart';
import 'package:computer_lab_inventory_application/features/user/domain/usecases/add_user.dart';
import 'package:computer_lab_inventory_application/features/user/domain/usecases/forgot_password.dart';
import 'package:computer_lab_inventory_application/features/user/domain/usecases/get_all_user.dart';
import 'package:computer_lab_inventory_application/features/user/domain/usecases/get_user.dart';
import 'package:computer_lab_inventory_application/features/user/presentation/bloc/user_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:google_sign_in/google_sign_in.dart';

var myInjection =
    GetIt.instance; // merupakan tempat penampungan semua dependencies

//Kita akan men-inject semua dependencies
Future<void> injectionInit() async {
  //Google SignIn
  myInjection.registerLazySingleton(() => GoogleSignIn.instance);

  // Register FirebaseAuth
  myInjection.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  // Register FirebaseFirestore
  myInjection.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );

  //Bloc
  myInjection.registerFactory(
    () => AuthBloc(myInjection(), myInjection(), myInjection(), myInjection()),
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
    () => GetCurrentUserUsecase(
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
      firebaseAuth: myInjection(),
      googleSignIn: myInjection(),
      authRemoteDatasource: myInjection(),
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
      googleSignIn: myInjection(),
      firebaseAuth: myInjection(),
      firestore: myInjection(),
    ),
  );
}
