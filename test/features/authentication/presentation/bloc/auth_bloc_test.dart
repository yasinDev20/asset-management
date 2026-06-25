import 'package:assetmanagement/features/authentication/domain/repositories/auth_repository.dart';
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
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockEmailPasswordSignUsecase extends Mock
    implements EmailPasswordSignUsecase {}

class MockEmailRegisterUsecase extends Mock implements EmailRegisterUsecase {}

class MockGoogleSignInUsecase extends Mock implements GoogleSignInUsecase {}

class MockGetUserUsecase extends Mock implements GetUserUsecase {}

class MockForgotPasswordUsecase extends Mock implements ForgotPasswordUsecase {}

class MockSignOutUsecase extends Mock implements SignOutUsecase {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late MockEmailRegisterUsecase mockEmailRegisterUsecase;
  late MockEmailPasswordSignUsecase mockEmailPasswordSignUsecase;
  late MockGoogleSignInUsecase mockGoogleSignInUsecase;
  late MockGetUserUsecase mockGetUserUsecase;
  late MockForgotPasswordUsecase mockForgotPasswordUsecase;
  late MockSignOutUsecase mockSignOutUsecase;
  late AuthBloc authBloc;

  const id = 'id';
  const name = 'name';
  const email = 'test@email.com';
  const password = '123456';
  final authEntity = AuthEntity(
    user: UserEntity(
      id: id,
      email: email,
      name: name,
      createdAt: DateTime(2025),
    ),
  );

  setUp(() {
    mockEmailRegisterUsecase = MockEmailRegisterUsecase();
    mockEmailPasswordSignUsecase = MockEmailPasswordSignUsecase();
    mockGoogleSignInUsecase = MockGoogleSignInUsecase();
    mockGetUserUsecase = MockGetUserUsecase();
    mockSignOutUsecase = MockSignOutUsecase();
    mockForgotPasswordUsecase = MockForgotPasswordUsecase();
    mockAuthRepository = MockAuthRepository();
    when(
      () => mockAuthRepository.authStateChanges(),
    ).thenAnswer((_) => Stream.empty());

    authBloc = AuthBloc(
      authRepository: mockAuthRepository,
      emailRegisterUsecase: mockEmailRegisterUsecase,
      getUserUseCase: mockGetUserUsecase,
      emailPasswordSignUsecase: mockEmailPasswordSignUsecase,
      googleSignInUsecase: mockGoogleSignInUsecase,
      forgotPasswordUseCase: mockForgotPasswordUsecase,
      signOutUsecase: mockSignOutUsecase,
    );
  });

  tearDown(() => authBloc.close());

  test('initial state is AuthStatus.initial', () {
    expect(authBloc.state, AuthState(status: AuthStatus.initial));
  });

  //TODO : grouping test

  group('EmailRegisterEvent', () {
    blocTest<AuthBloc, AuthState>(
      'emits [loading, succsess] when register is succeds.',
      setUp: () {
        when(
          () => mockEmailRegisterUsecase.call(
            name: name,
            email: email,
            password: password,
          ),
        ).thenAnswer((_) async => Right(unit));
      },
      build: () => authBloc,
      act: (bloc) => bloc.add(
        EmailRegisterEvent(name: name, email: email, password: password),
      ),
      expect: () => <AuthState>[
        AuthState(status: AuthStatus.loading),
        AuthState(status: AuthStatus.success),
      ],

      verify: (_) {
        verify(
          () => mockEmailRegisterUsecase.call(
            name: name,
            email: email,
            password: password,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockEmailRegisterUsecase);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [loading, failure] when register fails',
      setUp: () {
        when(
          () => mockEmailRegisterUsecase.call(
            name: name,
            email: email,
            password: password,
          ),
        ).thenAnswer((_) async => Left(ServerFailure(message: 'Server error')));
      },
      build: () => authBloc,
      act: (bloc) => bloc.add(
        EmailRegisterEvent(name: name, email: email, password: password),
      ),
      expect: () => <AuthState>[
        AuthState(status: AuthStatus.loading),
        AuthState(
          status: AuthStatus.failure,
          failure: ServerFailure(message: 'Server error'),
        ),
      ],

      verify: (_) {
        verify(
          () => mockEmailRegisterUsecase.call(
            name: name,
            email: email,
            password: password,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockEmailRegisterUsecase);
      },
    );
  });
  group('EmailPasswordSignEvent', () {
    blocTest<AuthBloc, AuthState>(
      'emits [loading, succsess] when sign in is succeds.',
      setUp: () {
        when(
          () => mockEmailPasswordSignUsecase.call(
            email: email,
            password: password,
          ),
        ).thenAnswer((_) async => Right(unit));
      },
      build: () => authBloc,
      act: (bloc) =>
          bloc.add(EmailPasswordSignEvent(email: email, password: password)),
      expect: () => <AuthState>[
        AuthState(status: AuthStatus.loading),
        AuthState(status: AuthStatus.success),
      ],

      verify: (_) {
        verify(
          () => mockEmailPasswordSignUsecase.call(
            email: email,
            password: password,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockEmailPasswordSignUsecase);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [loading, failure] when sign in fails',
      setUp: () {
        when(
          () => mockEmailPasswordSignUsecase.call(
            email: email,
            password: password,
          ),
        ).thenAnswer((_) async => Left(ServerFailure(message: 'Server error')));
      },
      build: () => authBloc,
      act: (bloc) =>
          bloc.add(EmailPasswordSignEvent(email: email, password: password)),
      expect: () => <AuthState>[
        AuthState(status: AuthStatus.loading),
        AuthState(
          status: AuthStatus.failure,
          failure: ServerFailure(message: 'Server error'),
        ),
      ],

      verify: (_) {
        verify(
          () => mockEmailPasswordSignUsecase.call(
            email: email,
            password: password,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockEmailPasswordSignUsecase);
      },
    );
  });

  group('LoggedInEvent', () {
    blocTest<AuthBloc, AuthState>(
      'emits [loading, (succsess, authEntity)] when logged in is succeds.',
      setUp: () {
        when(
          () => mockGetUserUsecase.call(id: id),
        ).thenAnswer((_) async => Right(authEntity));
      },
      build: () => authBloc,
      act: (bloc) => bloc.add(LoggedInEvent(userId: id)),
      expect: () => <AuthState>[
        AuthState(status: AuthStatus.loading),
        AuthState(authEntity: authEntity, status: AuthStatus.success),
      ],

      verify: (_) {
        verify(() => mockGetUserUsecase.call(id: id)).called(1);
        verifyNoMoreInteractions(mockGetUserUsecase);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [loading, failure] when logged in fails',
      setUp: () {
        when(
          () => mockGetUserUsecase.call(id: id),
        ).thenAnswer((_) async => Left(ServerFailure(message: 'Server error')));
      },
      build: () => authBloc,
      act: (bloc) => bloc.add(LoggedInEvent(userId: id)),
      expect: () => <AuthState>[
        AuthState(status: AuthStatus.loading),
        AuthState(
          status: AuthStatus.failure,
          failure: ServerFailure(message: 'Server error'),
        ),
      ],

      verify: (_) {
        verify(() => mockGetUserUsecase.call(id: id)).called(1);
        verifyNoMoreInteractions(mockGetUserUsecase);
      },
    );
  });
  group('LoggedOutEvent', () {
    blocTest<AuthBloc, AuthState>(
      'emits [(succsess, clearEntity)] when logged in is succeds.',
      build: () => authBloc,
      act: (bloc) => bloc.add(LoggedOutEvent()),
      expect: () => <AuthState>[
        AuthState(authEntity: null, status: AuthStatus.success),
      ],
    );
  });

  group('GoogleSignInEvent', () {
    blocTest<AuthBloc, AuthState>(
      'emits [loading, succsess] when sign in is succeds.',
      setUp: () {
        when(
          () => mockGoogleSignInUsecase.call(),
        ).thenAnswer((_) async => Right(unit));
      },
      build: () => authBloc,
      act: (bloc) => bloc.add(GoogleSignInEvent()),
      expect: () => <AuthState>[
        AuthState(status: AuthStatus.loading),
        AuthState(status: AuthStatus.success),
      ],

      verify: (_) {
        verify(() => mockGoogleSignInUsecase.call()).called(1);
        verifyNoMoreInteractions(mockGoogleSignInUsecase);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [loading, failure] when sign in fails',
      setUp: () {
        when(
          () => mockGoogleSignInUsecase.call(),
        ).thenAnswer((_) async => Left(ServerFailure(message: 'Server error')));
      },
      build: () => authBloc,
      act: (bloc) => bloc.add(GoogleSignInEvent()),
      expect: () => <AuthState>[
        AuthState(status: AuthStatus.loading),
        AuthState(
          status: AuthStatus.failure,
          failure: ServerFailure(message: 'Server error'),
        ),
      ],

      verify: (_) {
        verify(() => mockGoogleSignInUsecase.call()).called(1);
        verifyNoMoreInteractions(mockGoogleSignInUsecase);
      },
    );
  });
  group('SignOutEvent', () {
    blocTest<AuthBloc, AuthState>(
      'emits [loading, succsess] when sign out is succeds.',
      setUp: () {
        when(
          () => mockSignOutUsecase.call(),
        ).thenAnswer((_) async => Right(unit));
      },
      build: () => authBloc,
      act: (bloc) => bloc.add(SignOutEvent()),
      expect: () => <AuthState>[
        AuthState(status: AuthStatus.loading),
        AuthState(status: AuthStatus.success),
      ],

      verify: (_) {
        verify(() => mockSignOutUsecase.call()).called(1);
        verifyNoMoreInteractions(mockSignOutUsecase);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [loading, failure] when sign out request fails',
      setUp: () {
        when(
          () => mockSignOutUsecase.call(),
        ).thenAnswer((_) async => Left(ServerFailure(message: 'Server error')));
      },
      build: () => authBloc,
      act: (bloc) => bloc.add(SignOutEvent()),
      expect: () => <AuthState>[
        AuthState(status: AuthStatus.loading),
        AuthState(
          status: AuthStatus.failure,
          failure: ServerFailure(message: 'Server error'),
        ),
      ],

      verify: (_) {
        verify(() => mockSignOutUsecase.call()).called(1);
        verifyNoMoreInteractions(mockSignOutUsecase);
      },
    );
  });
  group('ForgotPasswordEvent', () {
    blocTest<AuthBloc, AuthState>(
      'emits [loading, success] when forgot password request is succeds.',
      setUp: () {
        when(
          () => mockForgotPasswordUsecase.call(email),
        ).thenAnswer((_) async => Right(unit));
      },
      build: () => authBloc,
      act: (bloc) => bloc.add(ForgotPasswordEvent(email)),
      expect: () => <AuthState>[
        AuthState(status: AuthStatus.loading),
        AuthState(status: AuthStatus.success),
      ],

      verify: (_) {
        verify(() => mockForgotPasswordUsecase.call(email)).called(1);
        verifyNoMoreInteractions(mockForgotPasswordUsecase);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'emits [loading, failure] when forgot password request fails',
      setUp: () {
        when(
          () => mockForgotPasswordUsecase.call(email),
        ).thenAnswer((_) async => Left(ServerFailure(message: 'Server error')));
      },
      build: () => authBloc,
      act: (bloc) => bloc.add(ForgotPasswordEvent(email)),
      expect: () => <AuthState>[
        AuthState(status: AuthStatus.loading),
        AuthState(
          status: AuthStatus.failure,
          failure: ServerFailure(message: 'Server error'),
        ),
      ],

      verify: (_) {
        verify(() => mockForgotPasswordUsecase.call(email)).called(1);
        verifyNoMoreInteractions(mockForgotPasswordUsecase);
      },
    );
  });
}
