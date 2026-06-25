part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class IntialEvent extends AuthEvent{
  @override
  List<Object?> get props => [];
}

class AuthLoggedOutEvent extends AuthEvent{
  @override
  List<Object?> get props =>[];
  
}
class AuthLoggedInEvent extends AuthEvent{
  final String userId;

  const AuthLoggedInEvent({required this.userId});

  @override
  List<Object?> get props =>[userId];
  
}

class EmailRegisterEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;
  const EmailRegisterEvent({required this. name, required this.email, required this.password});
  
  @override
  List<Object?> get props => [name, email, password];
  
  
}

class GoogleSignInEvent extends AuthEvent {
  

  const GoogleSignInEvent();
  @override
  List<Object?> get props => [];
  
}

class EmailPasswordSignEvent extends AuthEvent {
  final String email;
  final String password;

  const EmailPasswordSignEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}
class ForgotPassworEvent extends AuthEvent {
  final String email;

  const ForgotPassworEvent(
  this.email,
  );

  @override
  List<Object> get props => [email];
}

class  AuthSignOutEvent extends AuthEvent{
  @override
  List<Object?> get props => [];
  
}
 
  
