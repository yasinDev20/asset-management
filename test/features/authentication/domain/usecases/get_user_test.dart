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
  late MockAuthRepository mockAuthRepository;

  const String id = 'test';
  const String email = 'email';
  const String name = 'name';
  final authEntity = AuthEntity(
    user: UserEntity(
      id: id,
      email: email,
      name: name,
      createdAt: DateTime(2025),
    ),
  );

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    getUserUsecase = GetUserUsecase(mockAuthRepository);
  });

  test('should return Right(authEntity) when repo get user succeeds', () async {
    when(
      () => mockAuthRepository.getUser(id: id),
    ).thenAnswer((_) async => Right(authEntity));

    final result = await getUserUsecase.call(id: id);

    expect(result, equals(Right(authEntity)));
    verify(() => mockAuthRepository.getUser(id: id)).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should return Failure when repo get user fails', () async {
    when(() => mockAuthRepository.getUser(id: id)).thenAnswer(
      (_) async => Left(
        NetworkFailure(message: 'NETWORK FAILURE', code: 'NETWORK_FAILURE'),
      ),
    );

    final result = await getUserUsecase.call(id: id);

    expect(
      result,
      Left(NetworkFailure(message: 'NETWORK FAILURE', code: 'NETWORK_FAILURE')),
    );

    verify(() => mockAuthRepository.getUser(id: id)).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
