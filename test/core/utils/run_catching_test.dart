import 'dart:async';
import 'dart:io';

import 'package:assetmanagement/core/error/exception.dart';
import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/core/utils/run_catching.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  debugPrint = (String? message, {int? wrapWidth}) {};
  group('runCatching', () {
    test('should return Right when function succeeds', () async {
      final result = await runCatching(() async => 123);

      expect(result, isA<Right>());
      expect(result.getOrElse(() => -1), 123);
    });

    test(
      'should map AppException to Failure via ExceptionToFailureMapper',
      () async {
        final result = await runCatching(() async {
          throw AppException(
            type: ExceptionType.validation,
            message: 'Validation failed',
            code: 'VAL_ERR',
          );
        });

        expect(result.isLeft(), true);

        result.fold((failure) {
          expect(failure, isA<ValidationFailure>());
          expect(failure.message, 'Validation failed');
          expect(failure.code, 'VAL_ERR');
        }, (_) => fail('Should not return Right'));
      },
    );

    test('should map FirebaseAuthException to AuthFailure', () async {
      final result = await runCatching(() async {
        throw FirebaseAuthException(
          message: 'Wrong password',
          code: 'wrong-password',
        );
      });

      expect(result.isLeft(), true);

      result.fold((failure) {
        expect(failure, isA<AuthFailure>());
        expect(failure.message, 'Wrong password');
        expect(failure.code, 'wrong-password');
      }, (_) => fail('Should not return Right'));
    });

    test('should map FirebaseException to ServerFailure', () async {
      final result = await runCatching(() async {
        throw FirebaseException(
          plugin: 'firestore',
          message: 'Something failed',
          code: '500',
        );
      });

      expect(result.isLeft(), true);

      result.fold((failure) {
        expect(failure, isA<ServerFailure>());
        expect(failure.message, 'Something failed');
        expect(failure.code, '500');
      }, (_) => fail('Should not return Right'));
    });

    test('should map PlatformException to PermissionFailure', () async {
      final result = await runCatching(() async {
        throw PlatformException(
          message: 'Permission denied',
          code: 'PERMISSION',
        );
      });

      expect(result.isLeft(), true);

      result.fold((failure) {
        expect(failure, isA<PermissionFailure>());
        expect(failure.message, 'Permission denied');
        expect(failure.code, 'PERMISSION');
      }, (_) => fail('Should not return Right'));
    });

    test('should map SocketException to NetworkFailure', () async {
      final result = await runCatching(() async {
        throw const SocketException('No internet connection');
      });

      expect(result.isLeft(), true);

      result.fold((failure) {
        expect(failure, isA<NetworkFailure>());
        expect(failure.message, 'No internet connection');
      }, (_) => fail('Should not return Right'));
    });

    test('should map TimeoutException to NetworkFailure', () async {
      final result = await runCatching(() async {
        throw TimeoutException('Connection timed out');
      });

      expect(result.isLeft(), true);

      result.fold((failure) {
        expect(failure, isA<NetworkFailure>());
        expect(failure.message, 'Connection timed out');
      }, (_) => fail('Should not return Right'));
    });

    test('should map FormatException to ValidationFailure', () async {
      final result = await runCatching(() async {
        throw const FormatException('Invalid data format');
      });

      expect(result.isLeft(), true);

      result.fold((failure) {
        expect(failure, isA<ValidationFailure>());
        expect(failure.message, 'Invalid data format');
      }, (_) => fail('Should not return Right'));
    });

    test('should map unknown exception to UnknownFailure', () async {
      final result = await runCatching(() async {
        throw Exception('weird error');
      });

      expect(result.isLeft(), true);

      result.fold((failure) {
        expect(failure, isA<UnknownFailure>());
        expect(failure.message, contains('weird error'));
      }, (_) => fail('Should not return Right'));
    });
  });
}
