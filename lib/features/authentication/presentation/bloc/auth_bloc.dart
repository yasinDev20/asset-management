import 'package:bloc/bloc.dart';
import 'package:computer_lab_inventory_application/features/authentication/domain/entities/auth_entity.dart';
import 'package:computer_lab_inventory_application/features/authentication/domain/usecases/get_current_user.dart';
import 'package:computer_lab_inventory_application/features/authentication/domain/usecases/email_password_sign_in.dart';
import 'package:computer_lab_inventory_application/features/authentication/domain/usecases/google_sign_in.dart';
import 'package:computer_lab_inventory_application/features/authentication/domain/usecases/sign_out.dart';
import 'package:computer_lab_inventory_application/features/authentication/presentation/bloc/auth_event_listener.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:computer_lab_inventory_application/core/error/failure.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthEventListener _authEventListener;
  final GetUserUsecase _getCurrentUser;
  final EmailPasswordSignUsecase _emailPasswordSignUsecase;
  final GoogleSignInUsecase _googleSignInUsecase;
  final SignOutUsecase _signOutUsecase;

  AuthBloc(
    this._authEventListener,
    this._emailPasswordSignUsecase,
    this._googleSignInUsecase,
    this._signOutUsecase,
    this._getCurrentUser,
  ) : super(AuthInitialState()) {

     //ini diperlukan untuk mentrigger event bloc yang tidak bisa dilakukan oleh webrender button langsung
    _authEventListener.firebaseAuthEventListener(add);
    _authEventListener.googleSignInEventListener(add);
    on<AuthLoggedInEvent>((event, emit) async {
      if (state is AuthenticatedState || state is AuthLoadingState) return;
      final result = await _getCurrentUser.call(id: event.userId);

      result.fold(
        (failure) => emit(FailureState(failure: failure)),
        (success) => emit(AuthenticatedState(authEntity: success)),
      );
    });
    on<AuthLoggedOutEvent>((event, emit) {
      emit(UnAuthenticatedState());
    });

    on<EmailPasswordSignEvent>((event, emit) async {
      emit(AuthLoadingState());
      Either<Failure, AuthEntity> result = await _emailPasswordSignUsecase.call(
        event.email,
        event.password,
      );
      result.fold(
        (fail) {
          emit(FailureState(failure: fail));
        },
        (succses) {
          emit(AuthenticatedState(authEntity: succses));
        },
      );
    });

    on<GoogleSignInEvent>((event, emit) async {
      emit(AuthLoadingState());
      Either<Failure, AuthEntity> result = await _googleSignInUsecase.call(
        googleSignInAccaount: event.googleSignInAccaount,
      );
      result.fold(
        (fail) {
          emit(FailureState(failure: fail));
        },
        (succses) {
          emit(AuthenticatedState(authEntity: succses));
        },
      );
    });

    on<AuthSignOutEvent>((event, emit) async {
      Either<Failure, Unit> result = await _signOutUsecase.call();
      result.fold(
        (fail) {
          emit(FailureState(failure: fail));
        },
        (succes) {
          emit(AuthInitialState());
        },
      );
    });
  }

 
 
}
