part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class IntialEvent extends AuthEvent{
  @override
  List<Object?> get props => [];
}

class AuthCheckEvent extends AuthEvent{
  @override
  List<Object?> get props =>[];
  
}

class GoogleSignInEvent extends AuthEvent {
  @override
  List<Object?> get props => [];
  
}

class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;

  const AuthLoginEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class  AuthSignOutEvent extends AuthEvent{
  @override
  List<Object?> get props => [];
  
}
 
  
