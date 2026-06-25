part of 'auth_bloc.dart';

enum AuthStatus { initial, loading, success, failure }

class AuthState extends Equatable {
  final AuthStatus status;
  final AuthEntity? authEntity;
  final bool clearAuthEntity;
  final Failure? failure;

  const AuthState({
    this.status = AuthStatus.initial,
    this.authEntity,
    this.clearAuthEntity = false,
    this.failure,
  });

  @override
  List<Object?> get props => [status, authEntity, clearAuthEntity, failure];

  AuthState copyWith({
    AuthStatus? status,
    AuthEntity? authEntity,
    bool clearAuthEntity = false,
    Failure? failure,
  }) {
    return AuthState(
      status: status ?? this.status,
      authEntity: clearAuthEntity ? null : (authEntity ?? this.authEntity),
      failure: failure,
    );
  }
}
