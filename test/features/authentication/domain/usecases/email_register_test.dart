import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/authentication/domain/repositories/auth_repository.dart';
import 'package:assetmanagement/features/authentication/domain/usecases/email_register.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late EmailRegisterUsecase emailRegisterUsecase;

  const String name = 'name';
  const String email = 'email@gmail.com';
  const String password = 'password';
  setUp(() {
    mockAuthRepository = MockAuthRepository();
    emailRegisterUsecase = EmailRegisterUsecase(mockAuthRepository);
  });

  test('should return Right(unit) when repo register succeeds', () async {
    when(
      () => mockAuthRepository.emailRegister(
        name: name,
        email: email,
        password: password,
      ),
    ).thenAnswer((_) async => Right(unit));

    final result = await emailRegisterUsecase.call(
      name: name,
      email: email,
      password: password,
    );

    expect(result, Right(unit));
    verify(
      () => mockAuthRepository.emailRegister(
        name: name,
        email: email,
        password: password,
      ),
    ).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should return Failure when repo register fails', () async {
    const String email = 'email@gmail.com';
    const String password = 'password';

    when(
      () => mockAuthRepository.emailRegister(
        name: name,
        email: email,
        password: password,
      ),
    ).thenAnswer(
      (_) async => Left(AuthFailure(message: 'error', code: 'error code')),
    );

    final result = await emailRegisterUsecase.call(
      name: name,
      email: email,
      password: password,
    );

    expect(result, Left(AuthFailure(message: 'error', code: 'error code')));
    verify(
      () => mockAuthRepository.emailRegister(
        name: name,
        email: email,
        password: password,
      ),
    ).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
