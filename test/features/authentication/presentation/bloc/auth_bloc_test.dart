import 'package:bloc_test/bloc_test.dart';
import 'package:computer_lab_inventory_application/core/error/failure.dart';
import 'package:computer_lab_inventory_application/features/authentication/domain/entities/auth_entity.dart';
import 'package:computer_lab_inventory_application/features/authentication/domain/entities/user_entity.dart';
import 'package:computer_lab_inventory_application/features/authentication/domain/usecases/email_password_sign_in.dart';
import 'package:computer_lab_inventory_application/features/authentication/domain/usecases/get_current_user.dart';
import 'package:computer_lab_inventory_application/features/authentication/domain/usecases/google_sign_in.dart';
import 'package:computer_lab_inventory_application/features/authentication/domain/usecases/sign_out.dart';
import 'package:computer_lab_inventory_application/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:computer_lab_inventory_application/features/authentication/presentation/bloc/auth_event_listener.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockEmailPasswordSignUsecase extends Mock
    implements EmailPasswordSignUsecase {}

class MockGoogleSignInUsecase extends Mock implements GoogleSignInUsecase {}

class MockSignOutUsecase extends Mock implements SignOutUsecase {}

class MockGetUserUsecase extends Mock implements GetUserUsecase {}
class MockAuthEvenListener extends Mock implements AuthEventListener {}


void main() {
  late MockEmailPasswordSignUsecase mockEmailPasswordSignUsecase;
  late MockGoogleSignInUsecase mockGoogleSignInUsecase;
  late MockSignOutUsecase mockSignOutUsecase;
  late MockGetUserUsecase mockGetUserUsecase;
  late AuthBloc authBloc;
  late MockAuthEvenListener mockAuthEvenListener;

    setUp(() {
    
      mockEmailPasswordSignUsecase = MockEmailPasswordSignUsecase();
      mockGoogleSignInUsecase = MockGoogleSignInUsecase();
      mockSignOutUsecase = MockSignOutUsecase();
      mockGetUserUsecase = MockGetUserUsecase();
      mockAuthEvenListener= MockAuthEvenListener();
      authBloc = AuthBloc(
        mockAuthEvenListener,
        mockEmailPasswordSignUsecase,
        mockGoogleSignInUsecase,
        mockSignOutUsecase,
        mockGetUserUsecase,
      );
      

      when(() => mockAuthEvenListener.firebaseAuthEventListener(any()),).thenAnswer((_){});
      when(() => mockAuthEvenListener.googleSignInEventListener(any()),).thenAnswer((_){});

    });

    const email = 'test@email.com';
    const password = '123456';
    final authEntity = AuthEntity(
      user: UserEntity(id: 'test', email: 'email', name: 'name', createdAt: DateTime(2025)),
      accessToken: 'accessToken',
      tokenType: 'tokenType',
      refreshToken: 'refreshToken',
      expiresIn:  DateTime(2025),
      refreshExpiresAt:  DateTime(2025),
    );

   
    

  blocTest<AuthBloc, AuthState>(
    'emits [AuthLoadingState, AuthenticatedState] when login succes',
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
      'emits [EmailPasswordSignLoadingState, ErrorState] when login fails',
      build: () {
        // stub usecase.call(...) -> Left(Failure)
        when(() => mockEmailPasswordSignUsecase(email, password))
            .thenAnswer((_) async => Left(AuthFailure(message: 'AUTH FAILURE', code: 'AUTH FAILURE CODE')));
        return authBloc;
      },
      act: (bloc) => bloc.add(EmailPasswordSignEvent(email: email, password: password)),
      expect: () => [
        AuthLoadingState(),
         FailureState(failure: AuthFailure(message: 'AUTH FAILURE', code: 'AUTH FAILURE CODE') ),
      ],
      verify: (_) {
        verify(() => mockEmailPasswordSignUsecase(email, password)).called(1);
      },
    );
  

}
