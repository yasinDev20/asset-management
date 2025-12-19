import 'package:assetmanagement/core/error/exception.dart';
import 'package:assetmanagement/core/error/failure.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ExceptionToFailureMapper', () {
    test('should return NetworkFailure when type is network', () {
      final exception = AppException(
        type: ExceptionType.network,
        message: 'Network error',
        code: 'NET_CODE',
      );

      final result = ExceptionToFailureMapper.map(exception);

      expect(result, isA<NetworkFailure>());
      expect(result.message, 'Network error');
      expect(result.code, 'NET_CODE');
    });

    test('should return AuthFailure when type is auth', () {
      final exception = AppException(
        type: ExceptionType.auth,
        message: 'Auth error',
        code: 'AUTH_CODE',
      );

      final result = ExceptionToFailureMapper.map(exception);

      expect(result, isA<AuthFailure>());
      expect(result.message, 'Auth error');
      expect(result.code, 'AUTH_CODE');
    });
    test('should return ValidationFailure when type is validation', () {
      final exception = AppException(
        type: ExceptionType.validation,
        message: 'Validation error',
        code: 'VALID_CODE',
      );

      final result = ExceptionToFailureMapper.map(exception);

      expect(result, isA<ValidationFailure>());
      expect(result.message, 'Validation error');
      expect(result.code, 'VALID_CODE');
    });
    test('should return PermissionFailure when type is permission', () {
      final exception = AppException(
        type: ExceptionType.permission,
        message: 'Permission denied',
        code: 'PERMISSION_CODE',
      );

      final result = ExceptionToFailureMapper.map(exception);

      expect(result, isA<PermissionFailure>());
      expect(result.message, 'Permission denied');
      expect(result.code, 'PERMISSION_CODE');
    });
    test('should return CacheFailure when type is cache', () {
      final exception = AppException(
        type: ExceptionType.cache,
        message: 'Cache error',
        code: 'CACHE_CODE',
      );

      final result = ExceptionToFailureMapper.map(exception);

      expect(result, isA<CacheFailure>());
      expect(result.message, 'Cache error');
      expect(result.code, 'CACHE_CODE');
    });

    test('should return ServerFailure when type is server', () {
      final exception = AppException(
        type: ExceptionType.server,
        message: 'Server error',
        code: 'SERVER_CODE',
      );

      final result = ExceptionToFailureMapper.map(exception);

      expect(result, isA<ServerFailure>());
      expect(result.message, 'Server error');
      expect(result.code, 'SERVER_CODE');
    });

    test('should return UnknownFailure when type is unknown', () {
      final exception = AppException(
        type: ExceptionType.unknown,
        message: 'Unknown error',
        code: 'UNKNOWN_CODE',
      );

      final result = ExceptionToFailureMapper.map(exception);

      expect(result, isA<UnknownFailure>());
      expect(result.message, 'Unknown error');
      expect(result.code, 'UNKNOWN_CODE');
    });
  });
}
