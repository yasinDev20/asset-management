import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/authentication/domain/entities/auth_entity.dart';
import 'package:assetmanagement/features/authentication/domain/entities/user_entity.dart';
import 'package:assetmanagement/features/authentication/domain/repositories/auth_repository.dart';
import 'package:assetmanagement/features/authentication/domain/usecases/email_password_sign_in.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late EmailPasswordSignUsecase usecase;
  late MockAuthRepository authRepository;

  setUp(() {
    authRepository = MockAuthRepository();
    usecase = EmailPasswordSignUsecase(authRepository: authRepository);
  });

  test('should login and return User', () async {
    const email = 'test@email.com';
    const password = '123456';
    
    final authEntity = AuthEntity(
      user: UserEntity(id: 'test', email: 'email', name: 'name', createdAt: DateTime(2025)),
      accessToken: 'accessToken',
      tokenType: 'tokenType',
      refreshToken: 'refreshToken',
      expiresIn: DateTime(2025),
      refreshExpiresAt: DateTime(2025),
    );

    when(
      () => authRepository.emailPasswordSignIn(email: email, password: password),
    ).thenAnswer((_) async => Right(authEntity));

    // final result = await usecase(email, password);
    final result = await usecase.call(email, password);

    expect(result, equals(Right(authEntity)));
    verify(() => authRepository.emailPasswordSignIn(email: email, password: password)).called(1);
  });

  test('should return Failure when login fails', () async {
    const email = 'test@email.com';
    const password = 'wrong';

    when(() => authRepository.emailPasswordSignIn(email: email, password: password)).thenAnswer(
      (_) async => Left(AuthFailure(message: 'user not found', code: '404')),
    );

    final result = await usecase(email, password);

    expect(result, Left(AuthFailure(message: 'user not found', code: '404')));
    verify(() => authRepository.emailPasswordSignIn(email: email, password: password)).called(1);

    result.fold(
      (failure) {
      expect(failure, isA<AuthFailure>());
      expect(failure.message, 'user not found');
      expect(failure.code, '404');
    }, (_) => fail('Should return Left Failure'));
  });
}
