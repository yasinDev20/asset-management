part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class IntialEvent extends AuthEvent{
  @override
  List<Object?> get props => [];
}

class LoggedOutEvent extends AuthEvent{
  @override
  List<Object?> get props =>[];
  
}
class LoggedInEvent extends AuthEvent{
  final String userId;

  const LoggedInEvent({required this.userId});

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
class ForgotPasswordEvent extends AuthEvent {
  final String email;

  const ForgotPasswordEvent(
  this.email,
  );

  @override
  List<Object> get props => [email];
}

class  SignOutEvent extends AuthEvent{
  @override
  List<Object?> get props => [];
  
}
 
  
