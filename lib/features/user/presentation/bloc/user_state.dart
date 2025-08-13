part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {}

class GetAllUserLoadingState extends UserState {}

class GetAllUserErrorState extends UserState {
  final Failure failure;
  const GetAllUserErrorState({required this.failure});

  String get errorUiText => '[${failure.code ?? ''}] ${failure.message}';

  @override
  List<Object?> get props => [failure];
}

class GetAllUserSuccessState extends UserState {
  final List<UserEntity> users;
  final String? lastId;
  final bool isLoadingMore;
  final bool hasMore;
  const GetAllUserSuccessState({
    required this.users,
    required this.lastId,
    this.isLoadingMore = false,
    this.hasMore = true,
  });

  @override
  List<Object?> get props => [users, lastId, isLoadingMore, hasMore];
}

class ForgotPasswordSuccsessState extends UserState {}

class ForgotPasswordErrorState extends UserState {
  final Failure failure;
  const ForgotPasswordErrorState({required this.failure});

  String get errorUiText => '[${failure.code ?? ''}] ${failure.message}';

  @override
  List<Object?> get props => [failure];
}

class AddUserSuccessState extends UserState {}

class AddUserLoadingState extends UserState {}

class AddUserErrorState extends UserState {
  final Failure failure;
  const AddUserErrorState({required this.failure});

  String get errorUiText => '[${failure.code ?? ''}] ${failure.message}';

  @override
  List<Object?> get props => [failure];
}

class GetUserSuccsessState extends UserState {
  final UserEntity user;

  const GetUserSuccsessState({required this.user});
}

class GetUserLoadingState extends UserState {}

class GetUserErrorState extends UserState {
  final Failure failure;
  const GetUserErrorState({required this.failure});

  String get errorUiText => '[${failure.code ?? ''}] ${failure.message}';

  @override
  List<Object?> get props => [failure];
}
