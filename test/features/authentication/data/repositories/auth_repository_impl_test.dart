import 'package:assetmanagement/core/error/exception.dart';
import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/authentication/data/datasources/remote_datasource.dart';
import 'package:assetmanagement/features/authentication/data/models/auth_model.dart';
import 'package:assetmanagement/features/authentication/data/models/user_model.dart';
import 'package:assetmanagement/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRemoteDataSource extends Mock implements AuthRemoteDatasource {}

void main() {
  debugPrint = (String? message, {int? wrapWidth}) {}; //menghilangkan logging

  late MockAuthRemoteDataSource mockAuthRemoteDataSource;
  late AuthRepositoryImpl authRepositoryImpl;

  const id = 'id';
  const name = 'name';
  const email = 'test@email.com';
  const password = '123456';
  final authModel = AuthModel(
    user: UserModel(
      id: id,
      email: email,
      name: name,
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
    ),
  );

  final authEntity = authModel.toEntity();
  setUp(() {
    mockAuthRemoteDataSource = MockAuthRemoteDataSource();
    authRepositoryImpl = AuthRepositoryImpl(
      authRemoteDataSource: mockAuthRemoteDataSource,
    );
  });

  group('emailRegister', () {
    test(
      'should return Right(unit) when remote email register suceeds',
      () async {
        // Arrange
        when(
          () => mockAuthRemoteDataSource.emailRegister(
            name: name,
            email: email,
            password: password,
          ),
        ).thenAnswer((_) async {});

        // Act
        final result = await authRepositoryImpl.emailRegister(
          name: name,
          email: email,
          password: password,
        );

        // Assert
        expect(result, Right(unit));
        verify(
          () => mockAuthRemoteDataSource.emailRegister(
            name: name,
            email: email,
            password: password,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockAuthRemoteDataSource);
      },
    );

    test(
      'should return Left(Failure) when remote email register throws exception',
      () async {
        when(
          () => mockAuthRemoteDataSource.emailRegister(
            name: name,
            email: email,
            password: password,
          ),
        ).thenThrow(
          AppException(message: 'Network Failure', type: ExceptionType.network),
        );

        final result = await authRepositoryImpl.emailRegister(
          name: name,
          email: email,
          password: password,
        );

        expect(result, Left(NetworkFailure(message: 'Network Failure')));

        verify(
          () => mockAuthRemoteDataSource.emailRegister(
            name: name,
            email: email,
            password: password,
          ),
        ).called(1);

        verifyNoMoreInteractions(mockAuthRemoteDataSource);
      },
    );
  });
  group('emailPasswordSignIn', () {
    test(
      'should return Right(authEntity) when remote emailPasswordSignIn succeeds',
      () async {
        // Arrange
        when(
          () => mockAuthRemoteDataSource.emailPasswordSignIn(
            email: email,
            password: password,
          ),
        ).thenAnswer((_) async {});

        // Act
        final result = await authRepositoryImpl.emailPasswordSignIn(
          email: email,
          password: password,
        );

        // Assert
        expect(result, Right(unit));

        verify(
          () => mockAuthRemoteDataSource.emailPasswordSignIn(
            email: email,
            password: password,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockAuthRemoteDataSource);
      },
    );

    test(
      'should return Left(Failure) when remote emailPasswordSignIn throws exception',
      () async {
        when(
          () => mockAuthRemoteDataSource.emailPasswordSignIn(
            email: email,
            password: password,
          ),
        ).thenThrow(
          AppException(message: 'Network Failure', type: ExceptionType.network),
        );

        final result = await authRepositoryImpl.emailPasswordSignIn(
          email: email,
          password: password,
        );

        expect(result, Left(NetworkFailure(message: 'Network Failure')));

        verify(
          () => mockAuthRemoteDataSource.emailPasswordSignIn(
            email: email,
            password: password,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockAuthRemoteDataSource);
      },
    );
  });

  group('googleSignIn', () {
    test(
      'should return Right(authEntity) when remote googleSignIn succeeds',
      () async {
        // Arrange
        when(
          () => mockAuthRemoteDataSource.googleSignIn(),
        ).thenAnswer((_) async {});

        // Act
        final result = await authRepositoryImpl.googleSignIn();

        // Assert
        expect(result, Right(unit));

        verify(() => mockAuthRemoteDataSource.googleSignIn()).called(1);
        verifyNoMoreInteractions(mockAuthRemoteDataSource);
      },
    );

    test(
      'should return Left(Failure) when remote googleSignIn throws exception',
      () async {
        when(() => mockAuthRemoteDataSource.googleSignIn()).thenThrow(
          AppException(message: 'Network Failure', type: ExceptionType.network),
        );

        final result = await authRepositoryImpl.googleSignIn();

        expect(result, Left(NetworkFailure(message: 'Network Failure')));

        verify(() => mockAuthRemoteDataSource.googleSignIn()).called(1);
        verifyNoMoreInteractions(mockAuthRemoteDataSource);
      },
    );
  });

  group('getUser', () {
    test(
      'should return Right(authEntity) when remote getUser succeeds',
      () async {
        when(
          () => mockAuthRemoteDataSource.getUser(id),
        ).thenAnswer((_) async => authModel);

        final result = await authRepositoryImpl.getUser(id: id);

        expect(result, equals(Right(authEntity)));
        verify(() => mockAuthRemoteDataSource.getUser(id)).called(1);
        verifyNoMoreInteractions(mockAuthRemoteDataSource);
      },
    );

    test(
      'should return Left(Failure) when remote getUser throws exception',
      () async {
        when(() => mockAuthRemoteDataSource.getUser(id)).thenThrow(
          AppException(type: ExceptionType.network, message: 'Network Failure'),
        );

        final result = await authRepositoryImpl.getUser(id: id);

        expect(result, Left(NetworkFailure(message: 'Network Failure')));

        verify(() => mockAuthRemoteDataSource.getUser(id)).called(1);
        verifyNoMoreInteractions(mockAuthRemoteDataSource);
      },
    );
  });

  group('forgotPassword', () {
    test(
      'should return Right(unit) when remote forgotPassword succeeds',
      () async {
        // Arrange
        when(
          () => mockAuthRemoteDataSource.forgotPassword(email),
        ).thenAnswer((_) async {});

        // Act
        final result = await authRepositoryImpl.forgotPassword(email);

        // Assert
        expect(result, Right(unit));
        verify(() => mockAuthRemoteDataSource.forgotPassword(email)).called(1);
        verifyNoMoreInteractions(mockAuthRemoteDataSource);
      },
    );

    test(
      'should return Left(Failure) when forgot password throws exception',
      () async {
        when(() => mockAuthRemoteDataSource.forgotPassword(email)).thenThrow(
          AppException(message: 'Network Failure', type: ExceptionType.network),
        );

        final result = await authRepositoryImpl.forgotPassword(email);

        expect(result, Left(NetworkFailure(message: 'Network Failure')));

        verify(() => mockAuthRemoteDataSource.forgotPassword(email)).called(1);
        verifyNoMoreInteractions(mockAuthRemoteDataSource);
      },
    );
  });

  group('signOut', () {
    test('should return Right(unit) when remote signOut succeeds', () async {
      when(() => mockAuthRemoteDataSource.signOut()).thenAnswer((_) async {});
      final result = await authRepositoryImpl.signOut();

      expect(result, Right(unit));

      verify(() => mockAuthRemoteDataSource.signOut()).called(1);
      verifyNoMoreInteractions(mockAuthRemoteDataSource);
    });

    test(
      'should return Left(Failure) when sign out throws exception',
      () async {
        when(() => mockAuthRemoteDataSource.signOut()).thenThrow(
          AppException(type: ExceptionType.network, message: 'Network Failure'),
        );

        final result = await authRepositoryImpl.signOut();

        expect(result, Left(NetworkFailure(message: 'Network Failure')));

        verify(() => mockAuthRemoteDataSource.signOut()).called(1);
        verifyNoMoreInteractions(mockAuthRemoteDataSource);
      },
    );
  });
}
