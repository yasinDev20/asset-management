import 'package:bloc/bloc.dart';
import 'package:computer_lab_inventory_application/features/authentication/domain/entities/auth_entity.dart';
import 'package:computer_lab_inventory_application/features/authentication/domain/usecases/get_current_user.dart';
import 'package:computer_lab_inventory_application/features/authentication/domain/usecases/login.dart';
import 'package:computer_lab_inventory_application/features/authentication/domain/usecases/sign_in_with_google.dart';
import 'package:computer_lab_inventory_application/features/authentication/domain/usecases/sign_out.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:computer_lab_inventory_application/core/error/failure.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetCurrentUserUsecase _getCurrentUser;

  final EmailPasswordSignUsecase _login;
  final GoogleSignInUsecase _googleSignIn;
  final SignOutUsecase _signOut;
  AuthBloc(this._login, this._googleSignIn, this._signOut, this._getCurrentUser)
    : super(AuthInitial()) {
    on<AuthCheckEvent>((event, emit) async {
      emit(AuthLoadingState());
      final result = await _getCurrentUser.call();

      result.fold(
        (failure) {
          // Kalau gagal atau user nggak ada
          emit(AuthUnauthenticatedState(failure: failure));
        },
        (authEntity) {
          // Kalau user ada
          emit(AuthAuthenticatedState(auth: authEntity));
        },
      );
    });
    on<AuthLoginEvent>((event, emit) async {
      emit(AuthLoadingState());
      Either<Failure, AuthEntity> result = await _login.call(
        event.email,
        event.password,
      );
      result.fold(
        (fail) {
          emit(AuthErrorState(failure: fail));
        },
        (succses) {
          emit(AuthAuthenticatedState(auth: succses));
        },
      );
    });
    on<GoogleSignInEvent>((event, emit) async {
      emit(AuthLoadingState());
      Either<Failure, AuthEntity> result = await _googleSignIn.call();
      result.fold(
        (fail) {
          emit(AuthErrorState(failure: fail));
        },
        (succses) {
          emit(AuthAuthenticatedState(auth: succses));
        },
      );
    });
    on<AuthSignOutEvent>((event, emit) async {
      Either<Failure, Unit> result = await _signOut.call();
      result.fold(
        (fail) {
          emit(AuthErrorState(failure: fail));
        },
        (succes) {
          emit(AuthInitial());
        },
      );
    });
  }
}
