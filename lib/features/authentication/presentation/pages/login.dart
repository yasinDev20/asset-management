import 'package:computer_lab_inventory_application/core/constant/Icon_assets.dart';
import 'package:computer_lab_inventory_application/core/constant/image_assets.dart';
import 'package:computer_lab_inventory_application/core/common/widgets/button.dart';
import 'package:computer_lab_inventory_application/core/common/widgets/text_form_field.dart';
import 'package:computer_lab_inventory_application/core/utils/error_utils.dart';
import 'package:computer_lab_inventory_application/features/authentication/data/datasources/remote_datasource.dart';
import 'package:computer_lab_inventory_application/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/platform/web/web_wrapper.dart' as web;

/// The scopes required by this application.
// #docregion CheckAuthorization
// const List<String> scopes = <String>[
//   'https://www.googleapis.com/auth/contacts.readonly',
// ];
// #enddocregion CheckAuthorization

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    if (kIsWeb) {
      final authbloc = context.read<AuthBloc>();

      runCatching(() async {
        await GetIt.I<AuthRemoteDatasource>().googleInitialize();

        GetIt.I<AuthRemoteDatasource>().googleSignInEventListener(authbloc);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();

    if (kIsWeb) {
      GetIt.I<AuthRemoteDatasource>().disposeGoogleSignInEventListener();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                spacing: 24, // Spacing between logo and textfields + buttons

                children: <Widget>[
                  // Logo
                  Image(
                    image: AssetImage(ImageAssets.logo),
                    height: 156,
                    width: 210,
                  ),
                  //Textfields and Buttons
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 24,
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 16,
                          children: [
                            CommonTextFormField(
                              labelText: 'Email',
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: FormBuilderValidators.email(),
                            ),

                            CommonTextFormField(
                              labelText: 'Password',

                              controller: passwordController,
                              obscureText: true,
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(),
                                FormBuilderValidators.minLength(8),
                              ]),
                            ),
                          ],
                        ),
                      ),

                      // Email and Password sign Button
                      BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state is AuthErrorState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '[${state.failure.code ?? ''}] ${state.failure.message}',
                                ),
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          String text = '';
                          if (state is AuthLoadingState) {
                            text = 'Loading';
                          } else {
                            text = 'Masuk';
                          }

                          return Column(
                            spacing: 24,
                            children: [
                              BlocListener<AuthBloc, AuthState>(
                                listener: (context, state) {
                                  if (state is AuthAuthenticatedState) {
                                    return context.go('/');
                                  }
                                },
                                child: CommonButton(
                                  text: text,
                                  onPressed: () {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      context.read<AuthBloc>().add(
                                        AuthLoginEvent(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),

                              if (!kIsWeb)
                                CommonButton(
                                  icon: SvgPicture.asset(
                                    IconAssets.google,
                                    width: 18,
                                    height: 18,
                                  ),
                                  text: 'Masuk dengan google (khusus admin)',
                                  onPressed: () {
                                    context.read<AuthBloc>().add(
                                      GoogleSignInEvent(),
                                    );
                                  },
                                ),

                              if (kIsWeb) web.renderButton(),
                            ],
                          );
                        },
                      ),
                      if (kIsWeb)
                        Text('Daftar dengan akun google (khusus admin)'),
                    ],
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
