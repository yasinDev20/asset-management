import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart'; // For PlatformException
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../error/failure.dart';
import '../error/exception.dart';

//if datasource throw exception
//runCatching check Exception and return it
Future<Either<Failure, T>> runCatching<T>(Future<T> Function() fn) async {
  try {
    final result = await fn(); //prosess function yang diberikan
    return right(result); //jika tidak throw exception maka return result
  } on AppException catch (e, st) {
    debugPrint('App exception: $e\n$st');
    return left(ExceptionToFailureMapper.map(e));
  }
  //other exception
  on GoogleSignInException catch (e, st) {
    debugPrint('Firebase Auth exception: $e\n$st');
    return left(
      AuthFailure(
        message: e.description ?? 'Authentication failed',
        code: e.code.toString(),
      ),
    );
  }on PlatformException catch (e, st) {
    debugPrint('Platform exception: $e\n$st');
    return left(
      PermissionFailure(
        message: e.message ?? 'Platform error (${e.code})',
        code: e.code,
      ),
    );
  } on SocketException catch (e, st) {
    debugPrint('Socket exception: $e\n$st');
    return left(NetworkFailure(code: '"no_internet"', message: e.message));
  } on TimeoutException catch (e, st) {
    debugPrint('Timeout exception: $e\n$st');
    return left(
      NetworkFailure(
        code: '"timeout"',
        message: e.message ?? 'Connection timed out',
      ),
    );
  } on FormatException catch (e, st) {
    debugPrint('Format exception: $e\n$st');
    return left(
      ValidationFailure(code: '"invalid_format"', message: e.message),
    );
  } on PostgrestException catch (e, st) {
    debugPrint('Format exception: $e\n$st');
    if (e.code == '23505') {
      return left(
        ValidationFailure(code: e.code, message: 'Sudah pernah ditambahkan'),
      );
    }
    return left(UnknownFailure(message: 'Unknown error: $e', code: 'UNKNOWN'));
  } catch (e, st) {
    debugPrint('Unknown exception: $e\n$st');
    return left(UnknownFailure(message: 'Unknown error: $e', code: 'UNKNOWN'));
  }
}
