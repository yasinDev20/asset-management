import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController? controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextCapitalization? textCapitalization;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool readOnly;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final void Function()? onTap;
  final void Function(String value)? onSubmitted;
  final FocusNode? focusNode;
  final String? helperText;
  final int? maxLines;
  final int? minLines;

  const CommonTextField({
    super.key,
    required this.labelText,
    this.controller,
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
    this.onSubmitted,
    this.maxLines = 1,
    this.minLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      minLines: minLines,
      maxLines: maxLines,
      readOnly: readOnly,
      controller: controller,

      obscureText: obscureText, // Default to false if not provided
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      onTap: onTap,
      focusNode: focusNode,
      onSubmitted: onSubmitted,
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
