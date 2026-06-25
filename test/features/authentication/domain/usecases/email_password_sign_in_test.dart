import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/authentication/domain/repositories/auth_repository.dart';
import 'package:assetmanagement/features/authentication/domain/usecases/email_password_sign_in.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late EmailPasswordSignUsecase emailPasswordSignUsecase;
  late MockAuthRepository mockAuthRepository;

  const email = 'email';
  const password = 'password';

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    emailPasswordSignUsecase = EmailPasswordSignUsecase(mockAuthRepository);
  });

  test('should return Right(unit) when repo sign in succeds', () async {
    when(
      () => mockAuthRepository.emailPasswordSignIn(
        email: email,
        password: password,
      ),
    ).thenAnswer((_) async => Right(unit));

    final result = await emailPasswordSignUsecase.call(
      email: email,
      password: password,
    );

    expect(result, equals(Right(unit)));
    verify(
      () => mockAuthRepository.emailPasswordSignIn(
        email: email,
        password: password,
      ),
    ).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should return Failure when repo sign in fails', () async {
    when(
      () => mockAuthRepository.emailPasswordSignIn(
        email: email,
        password: password,
      ),
    ).thenAnswer((_) async => Left(AuthFailure(message: 'user not found')));

    final result = await emailPasswordSignUsecase(
      email: email,
      password: password,
    );

    expect(result, Left(AuthFailure(message: 'user not found')));
    verify(
      () => mockAuthRepository.emailPasswordSignIn(
        email: email,
        password: password,
      ),
    ).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
