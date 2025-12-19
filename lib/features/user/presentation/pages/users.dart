import 'package:assetmanagement/config/routes/route_names.dart';
import 'package:assetmanagement/core/common/widgets/bottom_sheet_filter.dart';
import 'package:assetmanagement/features/authentication/domain/entities/user_entity.dart';
import 'package:assetmanagement/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:assetmanagement/features/user/domain/params/user_filter.dart';
import 'package:assetmanagement/features/user/presentation/bloc/user_bloc.dart';
import 'package:assetmanagement/features/user/presentation/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  List<String> selectedLocations = [];
  TextEditingController searchNameController = TextEditingController();
  ScrollController usersScrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    context.read<UserBloc>().add(
      GetAllUserEvent(limit: 10, lastId: null),
    ); // load awal
    usersScrollController.addListener(() {
      final state = context.read<UserBloc>().state;
      if (usersScrollController.position.pixels >=
          usersScrollController.position.maxScrollExtent - 200) {
        if (state is GetAllUserSuccessState &&
            !state.isLoadingMore &&
            state.hasMore) {
          context.read<UserBloc>().add(
            GetAllUserEvent(
              limit: 10,
              lastId: state.lastId,
              oldUsers: state.users,
            ),
          );
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    searchNameController.dispose();
    usersScrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        return Scaffold(
          floatingActionButton:
              // (authState is AuthStateAuthenticated &&
              //     authState.auth.user.role == 'admin')
              // ? 
              
              FloatingActionButton(
                  child: Icon(Icons.person_add_outlined),
                  onPressed: () {
                    context.goNamed(RouteNames.addUser);
                  },
                )
              // : null
              ,

          appBar: AppBar(

            actions: [
               IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(AuthSignOutEvent());
            },
            tooltip: 'Sign Out',
          ),
            ],
            title: Text('Pengguna'),
          ),
          body: SelectionArea(
            child: Center(
              child: SizedBox(
                width: 500,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    spacing: 8,
                    children: [
                      //chips
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          spacing: 4,
                          children: [
                            SizedBox(
                              height: 33,
                              width: (MediaQuery.of(context).size.width >= 450)
                                  ? 250
                                  : 150,
                              child: TextField(
                                controller: searchNameController,
                                textCapitalization: TextCapitalization.words,
                                onChanged: (value) {
                                  context.read<UserBloc>().add(
                                    GetAllUserEvent(
                                      limit: 10,
                                      userFilter: UserFilter(
                                        location: selectedLocations,
                                        name: searchNameController.text,
                                      ),
                                    ),
                                  );
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  prefixIcon: Icon(Icons.search),
                                  hintText: 'Cari nama',
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.outlineVariant,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.outlineVariant,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            InputChip(
                              selected: selectedLocations.isNotEmpty,
                              label: Text('Lokasi'),
                              onPressed: () async {
                                final result = await showModalBottomSheet(
                                  showDragHandle: true,
                                  context: context,
                                  builder: (context) {
                                    return BottomSheetFilter(
                                      listOfChoice: [
                                        'Technopreneur dan Inkubator Bisnis',
                                        'Riset Data Science dan Business Intelligence',
                                        'Riset Kecerdasan Buatan dan Sains Komputer',
                                        'Pemrograman dan Pengembangan Aplikasi',
                                      ],
                                      initialSelected:
                                          selectedLocations, // ← kirim selected
                                    );
                                  },
                                );

                                if (result != null) {
                                  setState(() {
                                    selectedLocations = List<String>.from(
                                      result,
                                    );

                                    context.read<UserBloc>().add(
                                      GetAllUserEvent(
                                        limit: 10,
                                        userFilter: UserFilter(
                                          location: selectedLocations,
                                          name: searchNameController.text,
                                        ),
                                      ),
                                    ); // simpan pilihan
                                  });
                                }
                              },
                            ),

                            ActionChip(
                              label: Text('Lupa kata sandi'),
                              onPressed: () {
                                context.goNamed(RouteNames.forgotPassword);
                              },
                            ),
                          ],
                        ),
                      ),

                      //user list
                      Expanded(
                        child: BlocConsumer<UserBloc, UserState>(
                          listener: (context, state) {
                            if (state is! GetAllUserSuccessState) {
                              context.read<UserBloc>().add(
                                GetAllUserEvent(limit: 10),
                              ); //untuk mentriger kembali jika state berubah
                            }
                          },
                          builder: (context, state) {
                            return BlocBuilder<UserBloc, UserState>(
                              builder: (context, state) {
                                if (state is GetAllUserLoadingState) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is GetAllUserSuccessState) {
                                  if (state.users.isEmpty) {
                                    return Center(
                                      child: Text('Tidak ada pengguna.'),
                                    );
                                  }

                                  return ListView.separated(
                                    controller: usersScrollController,
                                    itemCount:
                                        state.users.length +
                                        (state.isLoadingMore ? 1 : 0),
                                    separatorBuilder: (_, _) =>
                                        SizedBox(height: 8),
                                    itemBuilder: (context, index) {
                                      if (index < state.users.length) {
                                        final UserEntity user =
                                            state.users[index];
                                        return UserCard(
                                          onTap:
                                              // (authState
                                              //         is AuthStateAuthenticated &&
                                              //     authState.auth.user.role ==
                                              //         'admin') ?
                                              () => 
                                              
                                              context.goNamed(
                                                  RouteNames.userDetail,
                                                  extra: user,
                                                  pathParameters: {
                                                    'userId': user.id,
                                                  },
                                                )
                                              // : null
                                              ,
                                          name: user.name,
                                        );
                                      } else if (state.isLoadingMore) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else {
                                        return SizedBox.shrink(); // Tidak tampilkan apa-apa jika tidak loading
                                      }
                                    },
                                  );
                                } else if (state is GetAllUserErrorState) {
                                  return Center(
                                    child: Text(
                                      'Gagal memuat data:[${state.failure.code}] ${state.failure.message}',
                                    ),
                                  );
                                }

                                return Container(); // default
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
