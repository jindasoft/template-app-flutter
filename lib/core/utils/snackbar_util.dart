import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SnackBarUtils {
  /// Show error snackbar
  static void showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message.tr(),

          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: ThemeConfig.colorError,
      ),
    );
  }

  /// Show success snackbar
  static void showSuccess(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message.tr(),
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: ThemeConfig.colorSuccess,
      ),
    );
  }

  /// Show info snackbar
  static void showInfo(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message.tr(),
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: ThemeConfig.colorInfo,
      ),
    );
  }

  /// Show warning snackbar
  static void showWarning(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message.tr(),
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: ThemeConfig.colorWarning,
      ),
    );
  }

  /// Show custom snackbar
  static void show(
    BuildContext context,
    String message, {
    Color backgroundColor = ThemeConfig.colorGreyMedium,
    Duration duration = const Duration(seconds: 4),
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message.tr(),
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: backgroundColor,
        duration: duration,
        action: action,
      ),
    );
  }
}
