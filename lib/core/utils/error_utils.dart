import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart'; // For PlatformException
import '../error/failure.dart';
import '../error/exception.dart';

Future<Either<Failure, T>> runCatching<T>(Future<T> Function() fn) async {
  try {
    final result = await fn();
    return right(result);
  } on AppException catch (e) {
    return left(ExceptionToFailureMapper.map(e));
  } on FirebaseAuthException catch (e) {
    return left(AuthFailure(
      message: e.message ?? 'Authentication failed',
      code: e.code,
    ));
  } on FirebaseException catch (e) {
    return left(ServerFailure(
      message: e.message ?? 'A Firebase error occurred',
      code: e.code,
    ));
  } on PlatformException catch (e) {
    return left(PermissionFailure(
      message: e.message ?? 'Platform error (${e.code})',
      code: e.code,
    ));
  } on SocketException {
    return left(NetworkFailure(message: 'No internet connection'));
  } on TimeoutException {
    return left(NetworkFailure(message: 'Connection timed out'));
  } on FormatException {
    return left(ValidationFailure(message: 'Invalid data format'));
  } catch (e) {
    return left(UnexpectedFailure(message: e.toString()));
  }
}
