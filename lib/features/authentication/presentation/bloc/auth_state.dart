part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthAuthenticatedState extends AuthState {
  final AuthEntity auth;

  const AuthAuthenticatedState({required this.auth});

  @override
  List<Object> get props => [auth];
}

class AuthLoadingState extends AuthState {}

class AuthErrorState extends AuthState {
  final Failure failure;

  const AuthErrorState({required this.failure});
  String get message => '[${failure.code}] ${failure.message}';

  @override
  List<Object> get props => [failure];
}

class AuthUnauthenticatedState extends AuthState {
  final Failure failure;

  const AuthUnauthenticatedState({required this.failure});

  String get message => '[${failure.code}] ${failure.message}';

  @override
  List<Object> get props => [failure];
}
