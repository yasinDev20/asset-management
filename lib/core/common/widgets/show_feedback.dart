import 'package:flutter/material.dart';

class ShowFeedback {
  //snackbar
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
  showSnackbar({
    required BuildContext context,
    bool isFailure = false,
    required String? text,
  }) {
    if (isFailure) {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(text ?? 'Sepertinya ada kesalahan'),
          backgroundColor: Colors.red,
        ),
      );
    }
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text ?? 'Berhasil'),
        backgroundColor: Colors.green,
      ),
    );
  }
}
