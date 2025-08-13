// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:computer_lab_inventory_application/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';

import 'package:computer_lab_inventory_application/core/common/widgets/bottom_sheet_filter.dart';
import 'package:computer_lab_inventory_application/core/common/widgets/button.dart';
import 'package:computer_lab_inventory_application/core/common/widgets/text_form_field.dart';
import 'package:computer_lab_inventory_application/features/authentication/domain/entities/user_entity.dart';
import 'package:computer_lab_inventory_application/features/user/presentation/bloc/user_bloc.dart';

class UserDetailPage extends StatefulWidget {
  final String? userId;
  final UserEntity? user;
  const UserDetailPage({super.key, this.userId, this.user});

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController identityNumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController termStartController = TextEditingController();
  TextEditingController termEndController = TextEditingController();
  TextEditingController locationsController = TextEditingController();
  DateTime? selectedTermStart;
  DateTime? selectedTermEnd;
  List<String> selectedlocations = [];
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();

    emailController.dispose();
    identityNumberController.dispose();
    nameController.dispose();
    termStartController.dispose();
    termEndController.dispose();
    locationsController.dispose();
  }

  @override
  void initState() {
    super.initState();

    

    if (widget.user != null) {
      final user = widget.user!;
      emailController.text = user.email;
      identityNumberController.text = user.identityNumber;
      nameController.text = user.name;
      termStartController.text =
          "${user.termStart.day}/${user.termStart.month}/${user.termStart.year}";
      termEndController.text =
          "${user.termEnd.day}/${user.termEnd.month}/${user.termEnd.year}";
      locationsController.text = user.locations.join(', ');
      selectedTermStart = user.termStart;
      selectedTermEnd = user.termEnd;
      selectedlocations = user.locations;
    }

    if (widget.user == null && widget.userId != null) {
      //widget user adalah extra dari route
      //ketika halaman di reload maka extra akan dispose
      //perlu mentriger getuser untuk pengganti extra
      context.read<UserBloc>().add(GetUserEvent(userId: widget.userId!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          (widget.userId != null) ? 'Edit pengguna' : 'Tambah pengguna',
        ),
      ),
      body: SelectionArea(
        child: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: 500,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  spacing: 24,
                  children: [
                    BlocListener<UserBloc, UserState>(
                      listener: (context, state) {
                        if (state is GetUserSuccsessState) {
                          final user = state.user;

                          emailController.text = user.email;
                          identityNumberController.text = user.identityNumber;
                          nameController.text = user.name;
                          termStartController.text =
                              "${user.termStart.day}/${user.termStart.month}/${user.termStart.year}";
                          termEndController.text =
                              "${user.termEnd.day}/${user.termEnd.month}/${user.termEnd.year}";
                          locationsController.text = user.locations.join(', ');
                          selectedTermStart = user.termStart;
                          selectedTermEnd = user.termEnd;
                          selectedlocations = user.locations;
                        }
                      },
                      child: Form(
                        key: _formKey,
                        child: Column(
                          spacing: 24,
                          children: [
                            //Texfield
                            CommonTextFormField(
                              keyboardType: TextInputType.emailAddress,

                              controller: emailController,
                              labelText: 'Email',
                              validator: FormBuilderValidators.email(),
                            ),
                            CommonTextFormField(
                              controller: identityNumberController,
                              labelText: 'No Identitas',

                              validator: FormBuilderValidators.required(),
                            ),
                            CommonTextFormField(
                              controller: nameController,
                              validator: FormBuilderValidators.required(),
                              textCapitalization: TextCapitalization.words,
                              labelText: 'Nama',
                            ),

                            TextFormField(
                              controller: termStartController,
                              readOnly: true,
                              validator: FormBuilderValidators.required(),
                              onTap: () async {
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(3000),
                                  initialDate: DateTime.now(),
                                );

                                if (picked != null) {
                                  selectedTermStart = picked;
                                  termStartController.text =
                                      "${picked.day}/${picked.month}/${picked.year}";
                                }
                              },

                              decoration: InputDecoration(
                                labelText: 'Mulai Jabatan',
                                border: OutlineInputBorder(),
                              ),
                            ),

                            TextFormField(
                              validator: FormBuilderValidators.required(),
                              controller: termEndController,
                              readOnly: true,
                              onTap: () async {
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(3000),
                                  initialDate: DateTime.now(),
                                );

                                if (picked != null) {
                                  selectedTermEnd = picked;
                                  termEndController.text =
                                      "${picked.day}/${picked.month}/${picked.year}";
                                }
                              },

                              decoration: InputDecoration(
                                labelText: 'Akhir Jabatan',
                                border: OutlineInputBorder(),
                              ),
                            ),

                            TextFormField(
                              validator: FormBuilderValidators.required(),
                              controller: locationsController,
                              readOnly: true,
                              onTap: () async {
                                final result = await showModalBottomSheet(
                                  context: context,
                                  builder: (context) => BottomSheetFilter(
                                    initialSelected: selectedlocations,
                                    listOfChoice: [
                                      'Technopreneur dan Inkubator Bisnis',
                                      'Riset Data Science dan Business Intelligence',
                                      'Riset Kecerdasan Buatan dan Sains Komputer',
                                      'Pemrograman dan Pengembangan Aplikasi',
                                    ],
                                  ),
                                );

                                if (result != null) {
                                  selectedlocations = List.from(result);
                                  locationsController.text = result.join(', ');
                                }
                              },

                              decoration: InputDecoration(
                                suffixIcon: Icon(Icons.arrow_drop_down),
                                labelText: 'Lokasi',
                                border: OutlineInputBorder(),
                              ),
                            ),

                            BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                // if (state is AuthStateAuthenticated &&
                                //     state.auth.user.role == 'admin') 
                                    
                                    {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (widget.userId == null) Spacer(),
                                      if (widget.userId != null)
                                        CommonButton(
                                          text: 'Hapus',
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: Colors.white,
                                            backgroundColor: Theme.of(
                                              context,
                                            ).colorScheme.error,
                                          ),
                                          onPressed: () async {
                                            final result = await showDialog<bool>(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text(
                                                    'Menghapus pengguna?',
                                                  ),
                                                  content: Text(
                                                    'Apakah anda yakin menghapus pengguna',
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        return Navigator.pop(
                                                          context,
                                                          false,
                                                        );
                                                      },
                                                      child: Text('Tidak'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        return Navigator.pop(
                                                          context,
                                                          true,
                                                        );
                                                      },
                                                      child: Text('Iya'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );

                                            if (result != null &&
                                                result == true &&
                                                context.mounted) {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Pengguna dihapus',
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                        ),

                                        //TODO: buat usecase edit

                                      BlocListener<UserBloc, UserState>(
                                        listener: (context, state) {
                                          if (state is AddUserSuccessState) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'Berhasil menambahkan user',
                                                ),
                                              ),
                                            );
                                            context.pop();
                                          }

                                          if (state is AddUserErrorState) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  state.errorUiText,
                                                ),
                                              ),
                                            );

                                            
                                          }
                                        },
                                        child: CommonButton(
                                          text: (widget.userId != null)
                                              ? 'Edit'
                                              : 'Simpan',
                                          onPressed: () {
                                            final isValid =
                                                _formKey.currentState
                                                    ?.validate() ??
                                                false;

                                            if (isValid) {
                                              context.read<UserBloc>().add(
                                                AddUserEvent(
                                                  userData: UserEntity(
                                                    email: emailController.text,
                                                    name: nameController.text,
                                                    identityNumber:
                                                        identityNumberController
                                                            .text,
                                                    locations:
                                                        selectedlocations,
                                                    termStart:
                                                        selectedTermStart!,
                                                    termEnd: selectedTermEnd!,
                                                  ),
                                                ),
                                              );

                                           
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                }

                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
