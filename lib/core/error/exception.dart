
enum ExceptionType { network, auth, validation, server, unknown, cache, permission }
class AppException implements Exception {
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
}