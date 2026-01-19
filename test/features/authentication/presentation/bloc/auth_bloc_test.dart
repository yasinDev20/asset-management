import 'package:assetmanagement/features/authentication/domain/usecases/email_register.dart';
import 'package:assetmanagement/features/authentication/domain/usecases/forgot_password.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/authentication/domain/entities/auth_entity.dart';
import 'package:assetmanagement/features/authentication/domain/entities/user_entity.dart';
import 'package:assetmanagement/features/authentication/domain/usecases/email_password_sign_in.dart';
import 'package:assetmanagement/features/authentication/domain/usecases/get_user.dart';
import 'package:assetmanagement/features/authentication/domain/usecases/google_sign_in.dart';
import 'package:assetmanagement/features/authentication/domain/usecases/sign_out.dart';
import 'package:assetmanagement/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:assetmanagement/features/authentication/presentation/bloc/auth_event_listener.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockEmailPasswordSignUsecase extends Mock
    implements EmailPasswordSignUsecase {}

class MockEmailRegisterUsecase extends Mock implements EmailRegisterUsecase {}

class MockGoogleSignInUsecase extends Mock implements GoogleSignInUsecase {}

class MockGetUserUsecase extends Mock implements GetUserUsecase {}

class MockForgotPasswordUsecase extends Mock implements ForgotPasswordUsecase {}

class MockSignOutUsecase extends Mock implements SignOutUsecase {}

class MockAuthEvenListener extends Mock implements AuthEventListener {}

void main() {
  late MockEmailRegisterUsecase mockEmailRegisterUsecase;
  late MockEmailPasswordSignUsecase mockEmailPasswordSignUsecase;
  late MockGoogleSignInUsecase mockGoogleSignInUsecase;
  late MockGetUserUsecase mockGetUserUsecase;
  late MockForgotPasswordUsecase mockForgotPasswordUsecase;
  late MockSignOutUsecase mockSignOutUsecase;
  late AuthBloc authBloc;
  late MockAuthEvenListener mockAuthEvenListener;

  setUp(() {
    mockEmailRegisterUsecase = MockEmailRegisterUsecase();
    mockEmailPasswordSignUsecase = MockEmailPasswordSignUsecase();
    mockGoogleSignInUsecase = MockGoogleSignInUsecase();
    mockGetUserUsecase = MockGetUserUsecase();
    mockSignOutUsecase = MockSignOutUsecase();
    mockForgotPasswordUsecase = MockForgotPasswordUsecase();
    mockAuthEvenListener = MockAuthEvenListener();
    authBloc = AuthBloc(
      authEventListener: mockAuthEvenListener,
      emailRegisterUsecase: mockEmailRegisterUsecase,
      getUserUseCase: mockGetUserUsecase,
      emailPasswordSignUsecase: mockEmailPasswordSignUsecase,
      googleSignInUsecase: mockGoogleSignInUsecase,
      forgotPasswordUseCase: mockForgotPasswordUsecase,
      signOutUsecase: mockSignOutUsecase,
    );

    when(
      () => mockAuthEvenListener.firebaseAuthEventListener(any()),
    ).thenAnswer((_) {});
    when(
      () => mockAuthEvenListener.googleSignInEventListener(any()),
    ).thenAnswer((_) {});
  });

  const email = 'test@email.com';
  const password = '123456';
  final authEntity = AuthEntity(
    user: UserEntity(
      id: 'test',
      email: 'email',
      name: 'name',
      createdAt: DateTime(2025),
    ),
    accessToken: 'accessToken',
    tokenType: 'tokenType',
    refreshToken: 'refreshToken',
    expiresIn: DateTime(2025),
    refreshExpiresAt: DateTime(2025),
  );

  //TODO : grouping test
  blocTest<AuthBloc, AuthState>(
    'emits [AuthLoadingState, EmailRegisterSuccessState] when EmailRegisterEvent is added.',
    build: () {
      when(
        () => mockEmailRegisterUsecase.call(email: email, password: password),
      ).thenAnswer((_) async => Right(unit));
      return authBloc;
    },
    act: (bloc) =>
        bloc.add(EmailRegisterEvent(email: email, password: password)),
    expect: () => <AuthState>[AuthLoadingState(), EmailRegisterSuccessState()],
  );

  blocTest<AuthBloc, AuthState>(
    'emits [AuthLoadingState, AuthenticatedState] when EmailPasswordSignEvent is added',
    build: () {
      when(
        () => mockEmailPasswordSignUsecase.call(email, password),
      ).thenAnswer((_) async => Right(authEntity));

      return authBloc;
    },

    act: (bloc) =>
        bloc.add(EmailPasswordSignEvent(email: email, password: password)),
    expect: () => [
      AuthLoadingState(),
      AuthenticatedState(authEntity: authEntity),
    ],

    verify: (bloc) => verify(
      () => mockEmailPasswordSignUsecase.call(email, password),
    ).called(1),
  );

  blocTest<AuthBloc, AuthState>(
    'emits [AuthLoadingState, ErrorState] when fails',
    build: () {
      // stub usecase.call(...) -> Left(Failure)
      when(() => mockEmailPasswordSignUsecase(email, password)).thenAnswer(
        (_) async => Left(
          AuthFailure(message: 'AUTH FAILURE', code: 'AUTH FAILURE CODE'),
        ),
      );
      return authBloc;
    },
    act: (bloc) =>
        bloc.add(EmailPasswordSignEvent(email: email, password: password)),
    expect: () => [
      AuthLoadingState(),
      FailureState(
        failure: AuthFailure(
          message: 'AUTH FAILURE',
          code: 'AUTH FAILURE CODE',
        ),
      ),
    ],
    verify: (_) {
      verify(() => mockEmailPasswordSignUsecase(email, password)).called(1);
    },
  );

  group('ForgotPasswortEvent handler test', () {
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoadingState, ForgotPasswordSuccessState] when EmailRegisterEvent is added.',
      build: () {
        when(
          () => mockForgotPasswordUsecase.call(email),
        ).thenAnswer((_) async => Right(unit));
        return authBloc;
      },
      act: (bloc) => bloc.add(ForgotPassworEvent(email)),
      expect: () => <AuthState>[
        AuthLoadingState(),
        ForgotPasswordSuccessState(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoadingState, ErrorState] when ForgotPassworEvent handler fails',
      build: () {
        // stub usecase.call(...) -> Left(Failure)
        when(() => mockForgotPasswordUsecase.call(email)).thenAnswer(
          (_) async => Left(
            AuthFailure(message: 'AUTH FAILURE', code: 'AUTH FAILURE CODE'),
          ),
        );
        return authBloc;
      },
      act: (bloc) => bloc.add(ForgotPassworEvent(email)),
      expect: () => [
        AuthLoadingState(),
        FailureState(
          failure: AuthFailure(
            message: 'AUTH FAILURE',
            code: 'AUTH FAILURE CODE',
          ),
        ),
      ],
      verify: (_) {
        verify(() => mockForgotPasswordUsecase(email)).called(1);
      },
    );
  });
}
