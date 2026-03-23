import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextFormField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextCapitalization? textCapitalization;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool readOnly;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final void Function()? onTap;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final String? helperText;
  final int? maxLines;
  final int? minLines;

  const CommonTextFormField({
    super.key,
    required this.labelText,
    required this.controller,
    this.readOnly = false,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.validator,
    this.textCapitalization,
    this.keyboardType,
    this.inputFormatters,
    this.onTap,
    this.focusNode,
    this.helperText,
    this.onFieldSubmitted,
    this.maxLines = 1,
    this.minLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: minLines,
      maxLines: maxLines,
      readOnly: readOnly,
      controller: controller,
      autovalidateMode: AutovalidateMode.onUnfocus,
      validator: validator,
      obscureText: obscureText, // Default to false if not provided
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      onTap: onTap,
      focusNode: focusNode,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        labelText: labelText,
        border: OutlineInputBorder(),
        errorMaxLines: 3,
        helperText: helperText,
      ),
    );
  }
}
