import 'package:assetmanagement/features/authentication/domain/usecases/email_register.dart';
import 'package:bloc/bloc.dart';
import 'package:assetmanagement/features/authentication/domain/entities/auth_entity.dart';
import 'package:assetmanagement/features/authentication/domain/usecases/get_user.dart';
import 'package:assetmanagement/features/authentication/domain/usecases/email_password_sign_in.dart';
import 'package:assetmanagement/features/authentication/domain/usecases/google_sign_in.dart';
import 'package:assetmanagement/features/authentication/domain/usecases/sign_out.dart';
import 'package:assetmanagement/features/authentication/presentation/bloc/auth_event_listener.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:assetmanagement/core/error/failure.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late final AuthEventListener _authEventListener;
  late final EmailRegisterUsecase _emailRegisterUsecase;
  late final GetUserUsecase _getUserUsacase;
  late final EmailPasswordSignUsecase _emailPasswordSignUsecase;
  late final GoogleSignInUsecase _googleSignInUsecase;
  late final SignOutUsecase _signOutUsecase;

  AuthBloc({
    required AuthEventListener authEventListener,
    required EmailRegisterUsecase emailRegisterUsecase,
    required GetUserUsecase getUserUseCase,
    required EmailPasswordSignUsecase emailPasswordSignUsecase,
    required GoogleSignInUsecase googleSignInUsecase,
    required SignOutUsecase signOutUsecase,
  }) : super(AuthInitialState()) {
    _authEventListener = authEventListener;
    _emailRegisterUsecase = emailRegisterUsecase;
    _getUserUsacase = getUserUseCase;
    _emailPasswordSignUsecase = emailPasswordSignUsecase;
    _googleSignInUsecase = googleSignInUsecase;
    _signOutUsecase = signOutUsecase;

    //ini diperlukan untuk mentrigger event bloc yang tidak bisa dilakukan oleh webrender button langsung
    _authEventListener.firebaseAuthEventListener(add);
    _authEventListener.googleSignInEventListener(add);

    on<EmailRegisterEvent>((event, emit) async {
      emit(AuthLoadingState());
      final result = await _emailRegisterUsecase.call(
        email: event.email,
        password: event.password,
      );

      result.fold(
        (l) => emit(FailureState(failure: l)),
        (r) => emit(EmailRegisterSuccessState()),
      );
    });

    on<AuthLoggedInEvent>((event, emit) async {
      if (state is AuthenticatedState || state is AuthLoadingState) return;
      final result = await _getUserUsacase.call(id: event.userId);

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
