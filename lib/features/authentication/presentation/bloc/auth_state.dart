part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitialState extends AuthState {
  @override
  List<Object> get props => [];
}
class AuthLoadingState extends AuthState {}

class AuthenticatedState extends AuthState {
  final AuthEntity authEntity;

  const AuthenticatedState({required this.authEntity});

  @override
  List<Object> get props => [authEntity];
}
class UnAuthenticatedState extends AuthState {
  

  

  @override
  List<Object> get props => [];
}



class CheckEventLoadingState extends AuthState {}

class FailureState extends AuthState {
  final Failure failure;

  const FailureState({required this.failure});
  String get message => '[${failure.code}] ${failure.message}';

  @override
  List<Object> get props => [failure];
}

