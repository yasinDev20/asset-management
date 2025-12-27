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

  test('should return unit when emailRegister success', () async {
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
}
