import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/authentication/domain/repositories/auth_repository.dart';
import 'package:assetmanagement/features/authentication/domain/usecases/sign_out.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late SignOutUsecase signOutUsecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    signOutUsecase = SignOutUsecase(mockAuthRepository);
  });

  test('should return Right(unit) when repo sign out succeeds', () async {
    when(
      () => mockAuthRepository.signOut(),
    ).thenAnswer((_) async => Right(unit));
    final result = await signOutUsecase.call();

    expect(result, equals(Right(unit)));
    verify(() => mockAuthRepository.signOut()).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should return Failure when repo sign out fails', () async {
    when(() => mockAuthRepository.signOut()).thenAnswer(
      (_) async => Left(
        NetworkFailure(message: 'Network Failure', code: 'NETWORK_FAILURE'),
      ),
    );
    final result = await signOutUsecase.call();

    expect(
      result,
      equals(
        Left(
          NetworkFailure(message: 'Network Failure', code: 'NETWORK_FAILURE'),
        ),
      ),
    );
    verify(() => mockAuthRepository.signOut()).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
