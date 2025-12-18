import 'package:computer_lab_inventory_application/core/error/failure.dart';
import 'package:computer_lab_inventory_application/features/authentication/domain/repositories/auth_repository.dart';
import 'package:computer_lab_inventory_application/features/authentication/domain/usecases/sign_out.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late SignOutUsecase signOutUsecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    signOutUsecase = SignOutUsecase(authRepository: mockAuthRepository);
  });

  test('should return Unit when sign out success', () async {
    when(
      () => mockAuthRepository.signOut(),
    ).thenAnswer((_) async => Right(unit));
    final result = await signOutUsecase.call();

    expect(result, equals(Right(unit)));
  });

  test('should return Failure when sign out fail', () async {
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
    result.fold(
      (l) => expect(l, isA<NetworkFailure>()),
      (r) => 'Should return Left Failure',
    );
  });
}
