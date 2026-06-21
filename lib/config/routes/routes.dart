import 'package:assetmanagement/config/routes/route_names.dart';
import 'package:assetmanagement/core/common/injection/injection.dart';
import 'package:assetmanagement/core/common/pages/not_found.dart';
import 'package:assetmanagement/features/asset/presentation/bloc/asset_bloc.dart';
import 'package:assetmanagement/features/asset/presentation/pages/asset_detail.dart';
import 'package:assetmanagement/features/asset_brand/domain/entities/edit_brand_entity.dart';
import 'package:assetmanagement/features/asset_brand/presentation/bloc/asset_brand_bloc.dart';
import 'package:assetmanagement/features/asset_category/domain/entities/edit_category_entity.dart';
import 'package:assetmanagement/features/asset_category/presentation/bloc/asset_category_bloc.dart';
import 'package:assetmanagement/features/asset_location/domain/entities/edit_location_entity.dart';
import 'package:assetmanagement/features/asset_location/presentation/bloc/asset_location_bloc.dart';
import 'package:assetmanagement/features/authentication/domain/entities/user_entity.dart';
import 'package:assetmanagement/features/authentication/presentation/pages/email_register.dart';
import 'package:assetmanagement/features/authentication/presentation/pages/login.dart';
import 'package:assetmanagement/features/home/presentation/pages/home.dart';
import 'package:assetmanagement/config/routes/app_shell.dart';
import 'package:assetmanagement/features/settings/presentation/pages/brands.dart';
import 'package:assetmanagement/features/settings/presentation/pages/edit_field.dart';
import 'package:assetmanagement/features/settings/presentation/pages/categories.dart';
import 'package:assetmanagement/features/settings/presentation/pages/locations.dart';
import 'package:assetmanagement/features/settings/presentation/pages/settings.dart';
import 'package:assetmanagement/features/user/presentation/pages/user_detail.dart';
import 'package:assetmanagement/features/authentication/presentation/pages/forgot_password.dart';
import 'package:assetmanagement/features/user/presentation/pages/users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MyRouter {
  static final GoRouter router = GoRouter(
    initialLocation:
        '/${RouteNames.home}', //ubah ini untuk ke page sedang di develop
    errorPageBuilder: (context, state) {
      return const MaterialPage(child: NotFoundPage());
    },

    // redirect: (context, state) {
    //   final authState = context.read<AuthBloc>().state;
    //   final currentPath = state.uri.path;
    //   final loginPath =
    //       '/${RouteNames.home}'; //ubah ini untuk ke page sedang di develop
    //   final forgotPasswordPath =
    //       '/${RouteNames.login}/${RouteNames.forgotPassword}';
    //   final emailRegisterPath =
    //       '/${RouteNames.login}/${RouteNames.emailRegister}';
    //   final publicPath = [loginPath, emailRegisterPath, forgotPasswordPath];

    //   // debugPrint(authState.toString());

    //   // 1️⃣ Biarkan auth proses dulu (ex: auto login)
    //   if (authState is AuthInitialState || authState is AuthLoadingState) {
    //     return null;
    //   }

    //   // 2️⃣ Sudah login → jangan ke login page
    //   if (authState is AuthenticatedState && currentPath == loginPath) {
    //     return '/';
    //   }

    //   // 3️⃣ Belum login → arahkan ke login
    //   if (authState is! AuthenticatedState &&
    //       !publicPath.contains(currentPath)) {
    //     return loginPath;
    //   }

    //   return null;
    // },
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
            path: RouteNames.home,
            name: RouteNames.home,
            pageBuilder: (context, state) =>
                const MaterialPage(child: HomePage()),
            routes: [
              //User
              GoRoute(
                path: RouteNames.user,
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

              //Detail asset
              GoRoute(
                path: '${RouteNames.assetDetail}/:id',
                name: RouteNames.assetDetail,
                pageBuilder: (context, state) => MaterialPage(
                  child: AssetDetailPage(
                    id: state.pathParameters['id'],
                    mode: AssetFormMode.edit,
                  ),
                ),
              ),
              //Add Asset
              GoRoute(
                path: RouteNames.addAsset,
                name: RouteNames.addAsset,
                pageBuilder: (context, state) => const MaterialPage(
                  child: AssetDetailPage(id: null, mode: AssetFormMode.add),
                ),
              ),

              //Settings
              GoRoute(
                path: RouteNames.settings,
                name: RouteNames.settings,
                pageBuilder: (context, state) =>
                    const MaterialPage(child: SettingsPage()),
                routes: [
                  //category
                  GoRoute(
                    path: RouteNames.categories,
                    name: RouteNames.categories,
                    pageBuilder: (context, state) => MaterialPage(
                      child: BlocProvider(
                        create: (context) => myInjection<AssetCategoryBloc>(),
                        child: CategoriesPage(),
                      ),
                    ),
                    routes: [
                      //edit
                      GoRoute(
                        path: '${RouteNames.editcategory}/:id/:name/:code',
                        name: RouteNames.editcategory,
                        pageBuilder: (context, state) {
                          return MaterialPage(
                            child: BlocProvider(
                              create: (context) =>
                                  myInjection<AssetCategoryBloc>(),
                              child: Builder(
                                builder: (context) {
                                  return BlocListener<
                                    AssetCategoryBloc,
                                    AssetCategoryState
                                  >(
                                    listener: (context, state) {
                                      if (state.status ==
                                          CategoryStatus.editSucces) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Berhasil mengedit kategori',
                                            ),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                        //refetch for homeview because AssetBloc is global state
                                        context.read<AssetBloc>().add(
                                          GetAssetsLiteEvent(),
                                        );

                                        //pop page and return true for triger refetch categories page
                                        context.pop(true);
                                      }
                                      if (state.status ==
                                          CategoryStatus.deleteSuccses) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Berhasil menghapus kategori',
                                            ),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                        //refetch for homeview because AssetBloc is global state
                                        context.read<AssetBloc>().add(
                                          GetAssetsLiteEvent(),
                                        );

                                        //pop page and return true for triger refetch categories page
                                        context.pop(true);
                                      }
                                      if (state.status ==
                                          CategoryStatus.failure) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              state.failure?.message ?? '',
                                            ),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    },
                                    child: EditFieldPage(
                                      title: 'kategori',
                                      id: state.pathParameters['id']!,
                                      code: state.pathParameters['code']!,
                                      name: state.pathParameters['name']!,
                                      onDeleted: () =>
                                          context.read<AssetCategoryBloc>().add(
                                            DeleteCategoryEvent(
                                              id: state.pathParameters['id']!,
                                            ),
                                          ),
                                      onEdit:
                                          ({
                                            required id,
                                            required code,
                                            required name,
                                          }) {
                                            context
                                                .read<AssetCategoryBloc>()
                                                .add(
                                                  EditCategoryEvent(
                                                    categoryEntity:
                                                        EditCategoryEntity(
                                                          id: id,
                                                          name: name,
                                                          code: code,
                                                        ),
                                                  ),
                                                );

                                            context
                                                .read<AssetCategoryBloc>()
                                                .add(SearchCategoriesEvent(''));
                                          },
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                  //brand
                  GoRoute(
                    path: RouteNames.brands,
                    name: RouteNames.brands,
                    pageBuilder: (context, state) => MaterialPage(
                      child: BlocProvider(
                        create: (context) => myInjection<AssetBrandBloc>(),
                        child: BrandsPage(),
                      ),
                    ),
                    routes: [
                      GoRoute(
                        path: '${RouteNames.editbrand}/:id/:name',
                        name: RouteNames.editbrand,
                        pageBuilder: (context, state) {
                          return MaterialPage(
                            child: BlocProvider(
                              create: (context) =>
                                  myInjection<AssetBrandBloc>(),
                              child: Builder(
                                builder: (context) {
                                  return BlocListener<
                                    AssetBrandBloc,
                                    AssetBrandState
                                  >(
                                    listener: (context, state) {
                                      if (state.status ==
                                          BrandStatus.editSucces) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Berhasil mengedit merek',
                                            ),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                        //refetch for homeview because AssetBloc is global state
                                        context.read<AssetBloc>().add(
                                          GetAssetsLiteEvent(),
                                        );

                                        //pop page and return true for triger refetch brands page
                                        context.pop(true);
                                      }
                                      if (state.status ==
                                          BrandStatus.deleteSuccses) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Berhasil menghapus merek',
                                            ),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                        //refetch for homeview because AssetBloc is global state
                                        context.read<AssetBloc>().add(
                                          GetAssetsLiteEvent(),
                                        );

                                        //pop page and return true for triger refetch brands page
                                        context.pop(true);
                                      }

                                      if (state.status == BrandStatus.failure) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              state.failure?.message ?? '',
                                            ),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    },
                                    child: EditFieldPage(
                                      title: 'merek',
                                      id: state.pathParameters['id']!,
                                      name: state.pathParameters['name']!,
                                      onDeleted: () =>
                                          context.read<AssetBrandBloc>().add(
                                            DeleteBrandEvent(
                                              id: state.pathParameters['id']!,
                                            ),
                                          ),
                                      onEdit:
                                          ({
                                            required id,
                                            required code,
                                            required name,
                                          }) {
                                            context.read<AssetBrandBloc>().add(
                                              EditBrandEvent(
                                                brandEntity: EditBrandEntity(
                                                  id: id,
                                                  name: name,
                                                ),
                                              ),
                                            );
                                          },
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),

                  //location
                  GoRoute(
                    path: RouteNames.locations,
                    name: RouteNames.locations,
                    pageBuilder: (context, state) => MaterialPage(
                      child: BlocProvider(
                        create: (context) => myInjection<AssetLocationBloc>(),
                        child: LocationsPage(),
                      ),
                    ),
                    routes: [
                      GoRoute(
                        path: '${RouteNames.editlocation}/:id/:name',
                        name: RouteNames.editlocation,
                        pageBuilder: (context, state) {
                          return MaterialPage(
                            child: BlocProvider(
                              create: (context) =>
                                  myInjection<AssetLocationBloc>(),
                              child: Builder(
                                builder: (context) {
                                  return BlocListener<
                                    AssetLocationBloc,
                                    AssetLocationState
                                  >(
                                    listener: (context, state) {
                                      if (state.status ==
                                          LocationStatus.editSucces) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Berhasil mengedit lokasi',
                                            ),
                                            backgroundColor: Colors.green,
                                          ),
                                        );

                                        //refetch for homeview because AssetBloc is global state
                                        context.read<AssetBloc>().add(
                                          GetAssetsLiteEvent(),
                                        );

                                        //pop page and return true for triger refetch locations page
                                        context.pop(true);
                                      }
                                      if (state.status ==
                                          LocationStatus.deleteSuccses) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Berhasil menghapus lokasi',
                                            ),
                                            backgroundColor: Colors.green,
                                          ),
                                        );

                                        //refetch for homeview because AssetBloc is global state
                                        context.read<AssetBloc>().add(
                                          GetAssetsLiteEvent(),
                                        );

                                        //pop page and return true for triger refetch locations page
                                        context.pop(true);
                                      }
                                      if (state.status ==
                                          LocationStatus.failure) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              state.failure?.message ?? '',
                                            ),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    },
                                    child: EditFieldPage(
                                      title: 'lokasi',
                                      id: state.pathParameters['id']!,
                                      name: state.pathParameters['name']!,
                                      onDeleted: () =>
                                          context.read<AssetLocationBloc>().add(
                                            DeleteLocationEvent(
                                              id: state.pathParameters['id']!,
                                            ),
                                          ),
                                      onEdit:
                                          ({
                                            required id,
                                            required code,
                                            required name,
                                          }) {
                                            context
                                                .read<AssetLocationBloc>()
                                                .add(
                                                  EditLocationEvent(
                                                    locationEntity:
                                                        EditLocationEntity(
                                                          id: id,
                                                          name: name,
                                                        ),
                                                  ),
                                                );
                                          },
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
