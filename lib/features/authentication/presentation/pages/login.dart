import 'package:assetmanagement/config/routes/route_names.dart';
import 'package:assetmanagement/core/constant/Icon_assets.dart';
import 'package:assetmanagement/core/constant/image_assets.dart';
import 'package:assetmanagement/core/common/widgets/button.dart';
import 'package:assetmanagement/core/common/widgets/text_form_field.dart';
import 'package:assetmanagement/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../core/platform/web/web_wrapper.dart' as web;

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
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
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
                          if (state is FailureState) {
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
                          final googleSignIn = GoogleSignIn.instance;

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
                                  if (state is AuthenticatedState) {
                                    return context.goNamed(RouteNames.products);
                                  }
                                },
                                child: CommonButton(
                                  text: text,
                                  onPressed: () {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      context.read<AuthBloc>().add(
                                        EmailPasswordSignEvent(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),

                              if (googleSignIn.supportsAuthenticate())
                                CommonButton(
                                  icon: SvgPicture.asset(
                                    IconAssets.google,
                                    width: 18,
                                    height: 18,
                                  ),
                                  text: 'Masuk dengan google',
                                  onPressed: () async {
                                    final messenger = ScaffoldMessenger.of(
                                      context,
                                    );
                                    try {
                                      await googleSignIn.authenticate();
                                    } on GoogleSignInException catch (e) {
                                      messenger.showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            e.description ??
                                                'failed authentication',
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                )
                              else ...<Widget>[
                                if (kIsWeb) web.renderButton(),
                                // ···
                              ],
                            ],
                          );
                        },
                      ),
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
