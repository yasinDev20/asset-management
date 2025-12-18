import 'package:computer_lab_inventory_application/core/error/exception.dart';
import 'package:computer_lab_inventory_application/core/error/failure.dart';
import 'package:computer_lab_inventory_application/features/authentication/data/datasources/remote_datasource.dart';
import 'package:computer_lab_inventory_application/features/authentication/data/models/auth_model.dart';
import 'package:computer_lab_inventory_application/features/authentication/data/models/user_model.dart';
import 'package:computer_lab_inventory_application/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:computer_lab_inventory_application/features/authentication/domain/entities/auth_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDatasource {}

void main() {
  debugPrint = (String? message, {int? wrapWidth}) {}; //menghilangkan logging

  late MockGoogleSignInAccount mockGoogleSignInAccount;
  late MockAuthRemoteDataSource authRemoteDataSource;
  late AuthRepositoryImpl authRepositoryImpl;
  late AuthModel authModel;
  late AuthEntity authEntity;
  late String email;
  late String password;

  setUp(() {
    mockGoogleSignInAccount = MockGoogleSignInAccount();

    email = 'test@email.com';
    password = '123456';

    authModel = AuthModel(
      user: UserModel(
        id: 'id',
        email: 'email',
        name: 'name',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      accessToken: 'accessToken',
      tokenType: 'tokenType',
      refreshToken: 'refreshToken',
      expiresIn: DateTime.now(),
      refreshExpiresAt: DateTime.now(),
    );

    authEntity = authModel.toEntity();

    authRemoteDataSource = MockAuthRemoteDataSource();
    authRepositoryImpl = AuthRepositoryImpl(
      authRemoteDataSource: authRemoteDataSource,
    );
  });

  group('emailPasswordSignIn', () {
    test('should return AuthEntity when emailPasswordSignIn success', () async {
      // Arrange
      when(
        () => authRemoteDataSource.emailPasswordSignIn(
          email: email,
          password: password,
        ),
      ).thenAnswer((_) async => authModel);

      // Act
      final result = await authRepositoryImpl.emailPasswordSignIn(
        email,
        password,
      );

      // Assert
      expect(result, Right(authEntity));

      verify(
        () => authRemoteDataSource.emailPasswordSignIn(
          email: email,
          password: password,
        ),
      ).called(1);
    });

    test(
      'should return Failure when emailPasswordSignIn throws exception',
      () async {
        when(
          () => authRemoteDataSource.emailPasswordSignIn(
            email: email,
            password: password,
          ),
        ).thenThrow(
          AppException(
            message: 'Network Failure',
            type: ExceptionType.network,
            code: 'NETWORK_ERROR',
          ),
        );

        final result = await authRepositoryImpl.emailPasswordSignIn(
          email,
          password,
        );

        expect(result.isLeft(), true);

        result.fold((failure) {
          expect(failure, isA<NetworkFailure>());
          expect(failure.message, 'Network Failure');
          expect(failure.code, 'NETWORK_ERROR');
        }, (_) => fail('Should not return Right'));

        verify(
          () => authRemoteDataSource.emailPasswordSignIn(
            email: email,
            password: password,
          ),
        ).called(1);
      },
    );
  });

  group('googleSignIn', () {
    test('should return AuthEntity when googleSignIn success', () async {
      // Arrange
      when(
        () => authRemoteDataSource.googleSignIn(googleSignInAccaount: mockGoogleSignInAccount),
      ).thenAnswer((_) async => authModel);

      // Act
      final result = await authRepositoryImpl.googleSignIn(googleSignInAccaount: mockGoogleSignInAccount);

      // Assert
      expect(result, Right(authEntity));

      verify(() => authRemoteDataSource.googleSignIn(googleSignInAccaount: mockGoogleSignInAccount)).called(1);
    });

    test('should return Failure when googleSignIn throws exception', () async {
      when(() => authRemoteDataSource.googleSignIn(googleSignInAccaount: mockGoogleSignInAccount)).thenThrow(
        AppException(
          message: 'Network Failure',
          type: ExceptionType.network,
          code: 'NETWORK_ERROR',
        ),
      );

      final result = await authRepositoryImpl.googleSignIn(googleSignInAccaount: mockGoogleSignInAccount);

      expect(result.isLeft(), true);

      result.fold((failure) {
        expect(failure, isA<NetworkFailure>());
        expect(failure.message, 'Network Failure');
        expect(failure.code, 'NETWORK_ERROR');
      }, (_) => fail('Should not return Right'));

      verify(() => authRemoteDataSource.googleSignIn(googleSignInAccaount: mockGoogleSignInAccount)).called(1);
    });
  });

  group('getCurrentUser', () {
    test('should return AuthEntity when getCurrentUser success', () async {
      when(
        () => authRemoteDataSource.getCurrentUser(id: authEntity.user.id),
      ).thenAnswer((_) async => authModel);

      final result = await authRepositoryImpl.getCurrentUser(
        id: authEntity.user.id,
      );

      expect(result, equals(Right(authEntity)));
      verify(
        () => authRemoteDataSource.getCurrentUser(id: authEntity.user.id),
      ).called(1);
    });

    test(
      'should return Failure when getCurrentUser throws exception',
      () async {
        when(
          () => authRemoteDataSource.getCurrentUser(id: authEntity.user.id),
        ).thenThrow(
          AppException(
            type: ExceptionType.network,
            code: 'NETWORK_ERROR',
            message: 'Network Failure',
          ),
        );

        final result = await authRepositoryImpl.getCurrentUser(
          id: authEntity.user.id,
        );

        expect(result.isLeft(), true);

        result.fold((failure) {
          expect(failure, isA<NetworkFailure>());
          expect(failure.message, 'Network Failure');
          expect(failure.code, 'NETWORK_ERROR');
        }, (_) => fail('Should not return Right'));

        verify(
          () => authRemoteDataSource.getCurrentUser(id: authEntity.user.id),
        ).called(1);
      },
    );
  });

  group('signOut', () {
    test('should return unit when signOut succes', () async {
      when(() => authRemoteDataSource.signOut()).thenAnswer((_) async => unit);
      final result = await authRepositoryImpl.signOut();

      expect(result, equals(Right(unit)));
      verify(() => authRemoteDataSource.signOut()).called(1);
    });

    test('should return Failure when signOut throws exception', () async {
      when(() => authRemoteDataSource.signOut()).thenThrow(
        AppException(
          type: ExceptionType.network,
          code: 'NETWORK_ERROR',
          message: 'Network Failure',
        ),
      );

      final result = await authRepositoryImpl.signOut();

      expect(result.isLeft(), true);

      result.fold((failure) {
        expect(failure, isA<NetworkFailure>());
        expect(failure.message, 'Network Failure');
        expect(failure.code, 'NETWORK_ERROR');
      }, (_) => fail('Should not return Right'));

      verify(() => authRemoteDataSource.signOut()).called(1);
    });
  });
}
