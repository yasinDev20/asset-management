import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/authentication/domain/entities/auth_entity.dart';
import 'package:assetmanagement/features/authentication/domain/entities/user_entity.dart';
import 'package:assetmanagement/features/authentication/domain/repositories/auth_repository.dart';
import 'package:assetmanagement/features/authentication/domain/usecases/google_sign_in.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}

void main() {
  late MockAuthRepository mockAuthRepository;
  late GoogleSignInUsecase googleSignInUsecase;
  late MockGoogleSignInAccount mockGoogleSignInAccount;

  setUp(() {
    mockGoogleSignInAccount = MockGoogleSignInAccount();
    mockAuthRepository = MockAuthRepository();
    googleSignInUsecase = GoogleSignInUsecase(mockAuthRepository);
  });

  test('should return Right(unit) when repo googleSignIn succeeds', () async {
    when(
      () => mockAuthRepository.googleSignIn(),
    ).thenAnswer((_) async => Right(unit));

    final result = await googleSignInUsecase.call();

    expect(result, equals(Right(unit)));

    verify(() => mockAuthRepository.googleSignIn()).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should return Failure when googleSignIn fails', () async {
    when(() => mockAuthRepository.googleSignIn()).thenAnswer(
      (_) async =>
          Left(AuthFailure(code: 'user_not_found', message: 'user not found')),
    );

    final result = await googleSignInUsecase.call();

    expect(
      result,
      equals(
        Left(AuthFailure(message: 'user not found', code: 'user_not_found')),
      ),
    );

    verify(() => mockAuthRepository.googleSignIn()).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });
}
