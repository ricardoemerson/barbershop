import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

sealed class MessageHelper {
  static void showInfo(String message, BuildContext context) {
    _showSnackbar(
      CustomSnackBar.info(message: message),
      context,
    );
  }

  static void showSuccess(String message, BuildContext context) {
    _showSnackbar(
      CustomSnackBar.success(message: message),
      context,
    );
  }

  static void showError(String message, BuildContext context) {
    _showSnackbar(
      CustomSnackBar.error(message: message),
      context,
    );
  }

  static void _showSnackbar(CustomSnackBar snackBar, BuildContext context) {
    showTopSnackBar(
      Overlay.of(context),
      snackBar,
      displayDuration: const Duration(seconds: 5),
    );
  }
}
