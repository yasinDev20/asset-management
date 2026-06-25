import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/authentication/domain/repositories/auth_repository.dart';
import 'package:assetmanagement/features/authentication/domain/usecases/forgot_password.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late ForgotPasswordUsecase forgotPasswordUsecase;

  const String email = 'email@gmail.com';
  setUp(() {
    mockAuthRepository = MockAuthRepository();
    forgotPasswordUsecase = ForgotPasswordUsecase(mockAuthRepository);
  });

  test(
    'should return Right(unit) when repo forgot password succeeds',
    () async {
      when(
        () => mockAuthRepository.forgotPassword(email),
      ).thenAnswer((_) async => Right(unit));

      final result = await forgotPasswordUsecase.call(email);

      expect(result, Right(unit));

      verify(() => mockAuthRepository.forgotPassword(email)).called(1);
    },
  );

  test('should return Failure when repo forgot password fails', () async {
    when(() => mockAuthRepository.forgotPassword(email)).thenAnswer(
      (_) async =>
          Left(AuthFailure(code: 'user_not_found', message: 'user not found')),
    );

    final result = await forgotPasswordUsecase.call(email);

    expect(
      result,
      equals(
        Left(AuthFailure(message: 'user not found', code: 'user_not_found')),
      ),
    );
  });
}
