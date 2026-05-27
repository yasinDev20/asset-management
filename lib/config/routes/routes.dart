import 'package:assetmanagement/config/routes/route_names.dart';
import 'package:assetmanagement/core/common/pages/not_found.dart';
import 'package:assetmanagement/features/asset/presentation/pages/asset_detail.dart';
import 'package:assetmanagement/features/authentication/domain/entities/user_entity.dart';
import 'package:assetmanagement/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:assetmanagement/features/authentication/presentation/pages/email_register.dart';
import 'package:assetmanagement/features/authentication/presentation/pages/login.dart';
import 'package:assetmanagement/features/home/presentation/pages/home.dart';
import 'package:assetmanagement/config/routes/app_shell.dart';
import 'package:assetmanagement/features/user/presentation/pages/user_detail.dart';
import 'package:assetmanagement/features/authentication/presentation/pages/forgot_password.dart';
import 'package:assetmanagement/features/user/presentation/pages/users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MyRouter {
  GoRouter get router => GoRouter(
    initialLocation: '/${RouteNames.assetDetail}', //ubah ini untuk ke page sedang di develop
    errorPageBuilder: (context, state) {
      return const MaterialPage(child: NotFoundPage());
    },

    redirect: (context, state) {
      final authState = context.read<AuthBloc>().state;
      final currentPath = state.uri.path;
      final loginPath = '/${RouteNames.assetDetail}'; //ubah ini untuk ke page sedang di develop
      final forgotPasswordPath =
          '/${RouteNames.login}/${RouteNames.forgotPassword}';
      final emailRegisterPath =
          '/${RouteNames.login}/${RouteNames.emailRegister}';
      final publicPath = [loginPath, emailRegisterPath, forgotPasswordPath];

      // debugPrint(authState.toString());

      // 1️⃣ Biarkan auth proses dulu (ex: auto login)
      if (authState is AuthInitialState || authState is AuthLoadingState) {
        return null;
      }

      // 2️⃣ Sudah login → jangan ke login page
      if (authState is AuthenticatedState && currentPath == loginPath) {
        return '/';
      }

      // 3️⃣ Belum login → arahkan ke login
      if (authState is! AuthenticatedState &&
          !publicPath.contains(currentPath)) {
        return loginPath;
      }

      return null;
    },

    routes: [
      //login
      GoRoute(
        path: '/${RouteNames.login}',
        name: RouteNames.login,
        pageBuilder: (context, state) => const MaterialPage(child: LoginPage()),
        routes: [
          GoRoute(
            path: RouteNames.emailRegister,
            name: RouteNames.emailRegister,
            pageBuilder: (context, state) =>
                const MaterialPage(child: EmailRegisterPage()),
          ),
          GoRoute(
            path: RouteNames.forgotPassword,
            name: RouteNames.forgotPassword,
            pageBuilder: (context, state) =>
                const MaterialPage(child: ForgotPasswordPage()),
          ),
        ],
      ),

      ShellRoute(
        builder: (context, state, child) {
          return AppShell(child: child);
        },
        routes: [
          //home
          GoRoute(
            path: '/',
            name: RouteNames.home,
            pageBuilder: (context, state) =>
                const MaterialPage(child: HomePage()),
            routes: [
              //User
              GoRoute(
                path: '/${RouteNames.user}',
                name: RouteNames.user,
                pageBuilder: (context, state) =>
                    const MaterialPage(child: UsersPage()),
                routes: [
                  //UserDetail
                  GoRoute(
                    path: '${RouteNames.userDetail}/:userId',
                    name: RouteNames.userDetail,
                    pageBuilder: (context, state) => MaterialPage(
                      //untuk menghemat query tambahkan extra karena extra tidak perlu query user lagi
                      child: UserDetailPage(
                        user: state.extra as UserEntity?,
                        userId: state.pathParameters['userId'],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),

      //Detail asset
      GoRoute(
        // path: '/${RouteNames.assetDetail}/:id',
        path: '/${RouteNames.assetDetail}',
        name: RouteNames.assetDetail,
        pageBuilder: (context, state) => MaterialPage(
          child: AssetDetailPage(
            id: state.pathParameters['id'],
            mode: AssetFormMode.edit,
          ),
        ),
      ),
    ],
  );
}
