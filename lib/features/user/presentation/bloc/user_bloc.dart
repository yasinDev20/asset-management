// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:assetmanagement/features/user/domain/params/user_filter.dart';
import 'package:assetmanagement/features/user/domain/usecases/add_user.dart';
import 'package:assetmanagement/features/user/domain/usecases/get_user.dart';
import 'package:equatable/equatable.dart';

import 'package:assetmanagement/core/error/failure.dart';
import 'package:assetmanagement/features/authentication/domain/entities/user_entity.dart';
import 'package:assetmanagement/features/user/domain/usecases/forgot_password.dart';
import 'package:assetmanagement/features/user/domain/usecases/get_all_user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final ForgotPasswordUseCase forgotPasswordUseCase;
  final GetAllUserUseCase getAllUserUseCase;
  final AddUserUsecase addUserUsecase;
  final GetUserUseCase getUserUseCase;

  UserBloc({
    required this.getUserUseCase,
    required this.forgotPasswordUseCase,
    required this.getAllUserUseCase,
    required this.addUserUsecase,
  }) : super(UserInitial()) {
    on<ForgotPasswordUserEvent>((event, emit) async {
      final result = await forgotPasswordUseCase.call(event.email);

      result.fold(
        (fail) {
          emit(ForgotPasswordErrorState(failure: fail));
        },
        (success) {
          emit(ForgotPasswordSuccsessState());
        },
      );
    });

    on<GetAllUserEvent>((event, emit) async {
      if (event.lastId != null) {
        emit(
          GetAllUserSuccessState(
            users: event.oldUsers,
            lastId: event.lastId,
            isLoadingMore: true,
            hasMore: true, // default true saat loading more
          ),
        );
      } else {
        emit(GetAllUserLoadingState());
      }

      final result = await getAllUserUseCase.call(
        userFilter: event.userFilter,
        limit: event.limit,
        lastId: event.lastId,
      );

      result.fold(
        (fail) {
          emit(GetAllUserErrorState(failure: fail));
        },
        (success) {
          final allUsers = [...event.oldUsers, ...success.users];
          final bool hasMore =
              success.users.length ==
              event
                  .limit; //karena jika data yang di dapat berkurang dari limit artinya tidak ada sisa data lagi di cloud
          emit(
            GetAllUserSuccessState(
              users: allUsers,
              lastId: success.lastId,
              isLoadingMore: false,
              hasMore: hasMore,
            ),
          );
        },
      );
    });

    on<AddUserEvent>((event, emit) async {
      final result = await addUserUsecase.call(event.userData);

      result.fold(
        (failure) {
          emit(AddUserErrorState(failure: failure));
        },
        (succses) {
          emit(AddUserSuccessState());
        },
      );
    });
    on<GetUserEvent>((event, emit) async {
      emit(GetUserLoadingState());
      final result = await getUserUseCase.call(event.userId);

      result.fold(
        (failure) {
          emit(GetUserErrorState(failure: failure));
        },
        (success) {
          emit(GetUserSuccsessState(user: success));
        },
      );
    });
  }
}
