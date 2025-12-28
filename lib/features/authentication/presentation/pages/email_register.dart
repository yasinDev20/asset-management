import 'package:assetmanagement/core/common/widgets/button.dart';
import 'package:assetmanagement/core/common/widgets/text_form_field.dart';
import 'package:assetmanagement/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class EmailRegisterPage extends StatefulWidget {
  const EmailRegisterPage({super.key});

  @override
  State<EmailRegisterPage> createState() => _EmailRegisterState();
}

class _EmailRegisterState extends State<EmailRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Buat akun')),
      body: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 500),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 24,
                children: [
                  CommonTextFormField(
                    validator: FormBuilderValidators.email(),
                    labelText: 'Email',
                    controller: emailController,
                  ),
                  CommonTextFormField(
                    obscureText: true,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(8),
                    ]),
                    labelText: 'Kata sandi',
                    controller: passwordController,
                  ),
                  CommonTextFormField(
                    obscureText: true,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.minLength(8),
                      (value) {
                        if (value != passwordController.text) {
                          return 'Password tidak sama';
                        }
                        return null;
                      },
                    ]),
                    labelText: 'Konfirmasi kata sandi',
                    controller: confirmPasswordController,
                  ),

                  BlocListener<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is EmailRegisterSuccessState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Akun berhasil terdaftar. Silahkan login',
                            ),
                          ),
                        );
                      }
                    },
                    child: CommonButton(
                      text: 'Buat akun',
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          context.read<AuthBloc>().add(
                            EmailRegisterEvent(
                              email: emailController.text,
                              password: passwordController.text,
                            ),
                          );
                        }
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
  }
}
