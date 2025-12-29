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
    mockGoogleSignInAccount =  MockGoogleSignInAccount();
    mockAuthRepository = MockAuthRepository();
    googleSignInUsecase = GoogleSignInUsecase(
       mockAuthRepository,
    );
  });

  test('should return AuthEntity when googleSignIn succeeds', () async {
    final authEntity = AuthEntity(
      user: UserEntity(
        id: 'test',
        email: 'email',
        name: 'name',
        createdAt: DateTime(2025),
      ),
      accessToken: 'accessToken',
      tokenType: 'tokenType',
      refreshToken: 'refreshToken',
      expiresIn: DateTime(2025),
      refreshExpiresAt: DateTime(2025),
    );

    when(
      () => mockAuthRepository.googleSignIn(googleSignInAccaount: mockGoogleSignInAccount),
    ).thenAnswer((_) async => Right(authEntity));

    final result = await googleSignInUsecase.call(googleSignInAccaount: mockGoogleSignInAccount);

    expect(result, equals(Right(authEntity)));
  });

  test('should return Failure when googleSignIn fails', () async {
    when(() => mockAuthRepository.googleSignIn(googleSignInAccaount: mockGoogleSignInAccount )).thenAnswer(
      (_) async =>
          Left(AuthFailure(code: 'user_not_found', message: 'user not found')),
    );

    final result = await googleSignInUsecase.call(googleSignInAccaount: mockGoogleSignInAccount);

    expect(
      result,
      equals(
        Left(AuthFailure(message: 'user not found', code: 'user_not_found')),
      ),
    );
  });
}
