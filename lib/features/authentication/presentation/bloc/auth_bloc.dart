import 'package:assetmanagement/features/authentication/domain/repositories/auth_repository.dart';
import 'package:assetmanagement/features/authentication/domain/usecases/email_register.dart';
import 'package:assetmanagement/features/authentication/domain/usecases/forgot_password.dart';
import 'package:bloc/bloc.dart';
import 'package:assetmanagement/features/authentication/domain/entities/auth_entity.dart';
import 'package:assetmanagement/features/authentication/domain/usecases/get_user.dart';
import 'package:assetmanagement/features/authentication/domain/usecases/email_password_sign_in.dart';
import 'package:assetmanagement/features/authentication/domain/usecases/google_sign_in.dart';
import 'package:assetmanagement/features/authentication/domain/usecases/sign_out.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:assetmanagement/core/error/failure.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late final AuthRepository _authRepository;
  late final EmailRegisterUsecase _emailRegisterUsecase;
  late final GetUserUsecase _getUserUsacase;
  late final EmailPasswordSignUsecase _emailPasswordSignUsecase;
  late final GoogleSignInUsecase _googleSignInUsecase;
  late final ForgotPasswordUsecase _forgotPasswordUsecase;
  late final SignOutUsecase _signOutUsecase;

  AuthBloc({
    required AuthRepository authRepository,
    required EmailRegisterUsecase emailRegisterUsecase,
    required GetUserUsecase getUserUseCase,
    required EmailPasswordSignUsecase emailPasswordSignUsecase,
    required GoogleSignInUsecase googleSignInUsecase,
    required ForgotPasswordUsecase forgotPasswordUseCase,
    required SignOutUsecase signOutUsecase,
  }) : super(AuthState()) {
    _authRepository = authRepository;
    _emailRegisterUsecase = emailRegisterUsecase;
    _getUserUsacase = getUserUseCase;
    _emailPasswordSignUsecase = emailPasswordSignUsecase;
    _googleSignInUsecase = googleSignInUsecase;
    _signOutUsecase = signOutUsecase;
    _forgotPasswordUsecase = forgotPasswordUseCase;

    //ini diperlukan untuk mentrigger event bloc yang tidak bisa dilakukan oleh webrender button googleSignin langsung
    // _authRepository.googleSignInStateChanges().listen((user) {
    //   if (user != null) {
    //     add(GoogleSignInEvent(googleSignInAccaount: user));
    //   }
    // });

    _authRepository.authStateChanges().listen((userId) {
      if (userId != null) {
        add(AuthLoggedInEvent(userId: userId));
      } else {
        add(AuthLoggedOutEvent());
      }
    });

    on<EmailRegisterEvent>((event, emit) async {
      emit(state.copyWith(status: AuthStatus.loading));
      final result = await _emailRegisterUsecase.call(
        name: event.name,
        email: event.email,
        password: event.password,
      );

      result.fold(
        (failure) =>
            emit(state.copyWith(failure: failure, status: AuthStatus.failure)),
        (r) => emit(state.copyWith(status: AuthStatus.success)),
      );
    });

    on<AuthLoggedInEvent>((event, emit) async {
      // if (state is AuthenticatedState || state is AuthLoadingState) return;
      final result = await _getUserUsacase.call(id: event.userId);

      result.fold((failure) {
        emit(state.copyWith(failure: failure, status: AuthStatus.failure));
      }, (r) => emit(state.copyWith(authEntity: r, status: AuthStatus.success)));
    });
    on<AuthLoggedOutEvent>((event, emit) {
      emit(state.copyWith(clearAuthEntity: true, status: AuthStatus.success));
    });

    on<EmailPasswordSignEvent>((event, emit) async {
      emit(state.copyWith(status: AuthStatus.loading));
      Either<Failure, AuthEntity> result = await _emailPasswordSignUsecase.call(
        event.email,
        event.password,
      );
      result.fold(
        (failure) {
          emit(state.copyWith(failure: failure, status: AuthStatus.failure));
        },
        (succsess) {
          emit(state.copyWith(authEntity: succsess, status: AuthStatus.success));
        },
      );
    });

    on<GoogleSignInEvent>((event, emit) async {
      emit(state.copyWith(status: AuthStatus.loading));
      final result = await _googleSignInUsecase.call(
        
      );
      result.fold(
        (failure) {
          emit(state.copyWith(failure: failure, status: AuthStatus.failure));
        },
        (succsess) {
          emit(state.copyWith(status: AuthStatus.success));
        },
      );
    });

    on<ForgotPassworEvent>((event, emit) async {
      emit(state.copyWith(status: AuthStatus.loading));
      final result = await _forgotPasswordUsecase.call(event.email);

      result.fold(
        (failure) =>
            emit(state.copyWith(failure: failure, status: AuthStatus.failure)),
        (r) => emit(state.copyWith(status: AuthStatus.success)),
      );
    });

    on<AuthSignOutEvent>((event, emit) async {
      Either<Failure, Unit> result = await _signOutUsecase.call();
      result.fold(
        (failure) {
          emit(state.copyWith(failure: failure, status: AuthStatus.failure));
        },
        (succes) {
          emit(state.copyWith(authEntity: null, status: AuthStatus.success));
        },
      );
    });
  }
}
