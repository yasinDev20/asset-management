// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

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
        return UnknownFailure(message: e.message, code: e.code);
    }
  }
}

//failure is object to comunicate with ui
abstract class Failure extends Equatable {
  final String message;
  final String? code;

  const Failure({required this.message, this.code});

  @override
  String toString() => '$runtimeType: $message (code: $code)';

  @override
  List<Object> get props => [message, ?code];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.code});
}

class NetworkFailure extends Failure {
  const NetworkFailure({required super.message, super.code});
}

class AuthFailure extends Failure {
  const AuthFailure({required super.message, super.code});
}

class ValidationFailure extends Failure {
  const ValidationFailure({required super.message, super.code});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message, super.code});
}

class PermissionFailure extends Failure {
  const PermissionFailure({required super.message, super.code});
}

class UnknownFailure extends Failure {
  const UnknownFailure({required super.message, super.code});
}
