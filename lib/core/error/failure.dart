import 'package:computer_lab_inventory_application/core/error/exception.dart';

class ExceptionToFailureMapper {
  static Failure map(AppException e) {
    switch (e.type) {
      case ExceptionType.network:
        return NetworkFailure(message: e.message, code: e.code);
      case ExceptionType.auth:
        return AuthFailure(message: e.message, code: e.code);
      case ExceptionType.validation:
        return ValidationFailure(message: e.message, code: e.code);
      case ExceptionType.permission:
        return PermissionFailure(message: e.message, code: e.code);
      case ExceptionType.cache:
        return CacheFailure(message: e.message, code: e.code);
      case ExceptionType.server:
        return ServerFailure(message: e.message, code: e.code);
      case ExceptionType.unknown:
        return UnexpectedFailure(message: e.message, code: e.code);
    }
  }
}

abstract class Failure {
  final String message;
  final String? code;

  Failure({required this.message, this.code});

  @override
  String toString() => '$runtimeType: $message (code: $code)';
}

class ServerFailure extends Failure {
  ServerFailure({required super.message, super.code});
}

class NetworkFailure extends Failure {
  NetworkFailure({required super.message, super.code});
}

class AuthFailure extends Failure {
  AuthFailure({required super.message, super.code});
}

class ValidationFailure extends Failure {
  ValidationFailure({required super.message, super.code});
}

class CacheFailure extends Failure {
  CacheFailure({required super.message, super.code});
}

class PermissionFailure extends Failure {
  PermissionFailure({required super.message, super.code});
}

class UnexpectedFailure extends Failure {
  UnexpectedFailure({required super.message, super.code});
}
