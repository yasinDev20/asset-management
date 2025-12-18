// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

enum ExceptionType { network, auth, validation, server, unknown, cache, permission }
class AppException with EquatableMixin implements Exception {
  final ExceptionType type;       // misalnya: network, unauthorized, server, validation, etc.
  final String message;
  final String? code;         // opsional: HTTP status code, kode lokal
  final StackTrace? stackTrace;

  AppException({
    required this.type,
    required this.message,
    this.code,
    this.stackTrace,
  });

  @override
  String toString() => '[${type.name}] $message (code: $code)';

  @override
  List<Object> get props => [type, message, ?code, ?stackTrace];
}

