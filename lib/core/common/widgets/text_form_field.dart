// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CommonTextFormField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextCapitalization? textCapitalization;

  final TextInputType? keyboardType;

  const CommonTextFormField({
    super.key,
    required this.labelText,
    required this.controller,
    this.obscureText = false,
    this.validator,
    this.textCapitalization,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.onUnfocus,
      validator: validator,
      obscureText: obscureText, // Default to false if not provided
      keyboardType: keyboardType,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
        errorMaxLines: 3,
      ),
    );
  }
}
