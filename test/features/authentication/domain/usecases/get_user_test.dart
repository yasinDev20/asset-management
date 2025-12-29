import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/authentication/domain/entities/auth_entity.dart';
import 'package:assetmanagement/features/authentication/domain/entities/user_entity.dart';
import 'package:assetmanagement/features/authentication/domain/repositories/auth_repository.dart';
import 'package:assetmanagement/features/authentication/domain/usecases/get_user.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late GetUserUsecase getUserUsecase;
  late MockAuthRepository authRepository;

  setUp(() {
    authRepository = MockAuthRepository();
    getUserUsecase = GetUserUsecase(
      authRepository,
    );
  });

  test('should return AuthEntity when get user succeeds', () async {
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

    when(
      () => authRepository.getUser(id: authEntity.user.id),
    ).thenAnswer((_) async => Right(authEntity));

    final result = await getUserUsecase.call(id: authEntity.user.id);

    expect(result, equals(Right(authEntity)));
    verify(
      () => authRepository.getUser(id: authEntity.user.id),
    ).called(1);
  });

  test('should return Failure when get user fails', () async {
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

    when(
      () => authRepository.getUser(id: authEntity.user.id),
    ).thenAnswer(
      (_) async => Left(
        NetworkFailure(message: 'NETWORK FAILURE', code: 'NETWORK_FAILURE'),
      ),
    );

    final result = await getUserUsecase.call(id: authEntity.user.id);

    expect(
      result,
      Left(NetworkFailure(message: 'NETWORK FAILURE', code: 'NETWORK_FAILURE')),
    );

    result.fold((l) {
      expect(l.code, equals('NETWORK_FAILURE'));
      expect(l.message, equals('NETWORK FAILURE'));
    }, (_) => fail('Should return Left Failure'));
  });
}
