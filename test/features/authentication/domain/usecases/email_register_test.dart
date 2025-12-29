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

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    emailRegisterUsecase = EmailRegisterUsecase(mockAuthRepository);
  });

  test('should return unit when emailRegister succeeds', () async {
    const String email = 'email@gmail.com';
    const String password = 'password';

    when(
      () => mockAuthRepository.emailRegister(email: email, password: password),
    ).thenAnswer((_) async => Right(unit));

    final result = await emailRegisterUsecase.call(
      email: email,
      password: password,
    );

    expect(result, Right(unit));
  });


   test('should return Failure when register fails', () async {
    const String email = 'email@gmail.com';
    const String password = 'password';

    when(() => mockAuthRepository.emailRegister(email: email, password: password)).thenAnswer(
      (_) async => Left(AuthFailure(message: 'error', code: 'error code')),
    );

    final result = await emailRegisterUsecase.call(email: email, password: password);

    expect(result, Left(AuthFailure(message: 'error', code: 'error code')));
    verify(() => mockAuthRepository.emailRegister(email: email, password: password)).called(1);

    result.fold(
      (failure) {
      expect(failure, isA<AuthFailure>());
      expect(failure.message, 'error');
      expect(failure.code, 'error code');
    }, (_) => fail('Should return Left Failure'));
  });
}
