// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetAllUserEvent extends UserEvent {
  final int limit;
  final String? lastId;
  final List<UserEntity> oldUsers;
  final UserFilter? userFilter;
  const GetAllUserEvent({
    required this.limit,
    this.lastId,
    this.oldUsers = const [],
     this.userFilter,
  });

  @override
  List<Object> get props => [limit, lastId ?? '', oldUsers];
}

class ForgotPasswordUserEvent extends UserEvent {
  final String email;
  const ForgotPasswordUserEvent({required this.email});

  @override
  List<Object> get props => [email];
}

class AddUserEvent extends UserEvent{
  final UserEntity userData;

  const AddUserEvent({required this.userData});

  @override
  List<Object> get props => [userData];
  
}

class GetUserEvent extends UserEvent{
  final String userId;

  const GetUserEvent({required this.userId});

  @override
  List<Object> get props => [userId];
  
}

