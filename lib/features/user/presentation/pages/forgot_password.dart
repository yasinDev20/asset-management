import 'package:assetmanagement/core/common/widgets/button.dart';
import 'package:assetmanagement/core/common/widgets/text_form_field.dart';
import 'package:assetmanagement/features/user/presentation/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lupa kata sandi')),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 500,
            child: Column(
              spacing: 24,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Form(
                    key: _formKey,
                    child: CommonTextFormField(
                      labelText: 'Email',
                      controller: emailController,
                      validator: FormBuilderValidators.email(),
                    ),
                  ),
                ),
            
                CommonButton(
                  text: 'Kirim link masuk',
                  onPressed: () {
                    final isValid = _formKey.currentState?.validate() ?? false;
                    if (isValid) {
                      context.read<UserBloc>().add(
                        ForgotPasswordUserEvent(email: emailController.text),
                      );
            
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Link dikirimkan ke email')),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
