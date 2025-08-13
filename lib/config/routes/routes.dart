import 'package:computer_lab_inventory_application/config/routes/route_names.dart';
import 'package:computer_lab_inventory_application/core/common/pages/not_found.dart';
import 'package:computer_lab_inventory_application/features/authentication/domain/entities/user_entity.dart';
import 'package:computer_lab_inventory_application/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:computer_lab_inventory_application/features/authentication/presentation/pages/login.dart';
import 'package:computer_lab_inventory_application/features/product/presentation/pages/root_page.dart';
import 'package:computer_lab_inventory_application/features/product/presentation/pages/products.dart';
import 'package:computer_lab_inventory_application/features/user/presentation/pages/user_detail.dart';
import 'package:computer_lab_inventory_application/features/user/presentation/pages/forgot_password.dart';
import 'package:computer_lab_inventory_application/features/user/presentation/pages/users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MyRouter {
  GoRouter get router => GoRouter(
    initialLocation: '/',

    errorPageBuilder: (context, state) {
      return const MaterialPage(child: NotFoundPage());
    },

    

    // redirect: (context, state) {
    //   final authState = context.read<AuthBloc>().state;
    //   final currentPath = state.uri.path;

    //   if (authState is AuthAuthenticatedState) {
    //     if (currentPath == '/${RouteNames.login}') {
    //       return '/';
    //     }
    //   }
      
    //    else {
    //     if (currentPath != '/${RouteNames.login}') {
    //       return '/${RouteNames.login}';
    //     }
    //   }
    //   return null;

    // },
    routes: [
      //login
      GoRoute(
        path: '/${RouteNames.login}',
        name: RouteNames.login,
        pageBuilder: (context, state) => const MaterialPage(child: LoginPage()),
      ),

      ShellRoute(
        builder: (context, state, child) {
          return RootPage(child: child);
        },
        routes: [
          //home
          GoRoute(
            path: '/',
            name: RouteNames.products,
            pageBuilder: (context, state) =>
                const MaterialPage(child: ProductsPage()),
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
                        child: UserDetailPage(user: state.extra as UserEntity?, userId: state.pathParameters['userId']),
                      ),
                    ),

                    //Add user
                    GoRoute(
                      path: RouteNames.addUser,
                      name: RouteNames.addUser,
                      pageBuilder: (context, state) => MaterialPage(
                        //untuk menghemat query tambahkan extra karena extra tidak perlu query user lagi
                        child: UserDetailPage(),
                      ),
                    ),

                  //ForgotPassword
                  GoRoute(
                    path: RouteNames.forgotPassword,
                    name: RouteNames.forgotPassword,
                    pageBuilder: (context, state) =>
                        const MaterialPage(child: ForgotPasswordPage()),
                  ),
                ],
              ),

              // //listOfProduct
              // GoRoute(
              //   path: RouteNames.listOfProducts,
              //   name: RouteNames.listOfProducts,
              //   pageBuilder: (context, state) =>
              //       const MaterialPage(child: HomePage()),
              // ),

              // //productDetail
              // GoRoute(
              //   path: RouteNames.productDetail,
              //   name: RouteNames.productDetail,
              //   pageBuilder: (context, state) =>
              //       const MaterialPage(child: HomePage()),
              // ),
            ],
          ),
        ],
      ),

      // //Add product
      // GoRoute(
      //   path: '/${RouteNames.productDetail}',
      //   name: RouteNames.productDetail,
      //   pageBuilder: (context, state) =>
      //       const MaterialPage(child: HomePage()),
      // ),
    ],
  );
}
