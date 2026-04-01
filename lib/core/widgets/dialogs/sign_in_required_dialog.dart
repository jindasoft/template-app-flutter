import 'package:template_app_flutter/modules/auth/pages/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class SigninRequiredDialog extends StatelessWidget {
  const SigninRequiredDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('sign_in_required_dialog.title'.tr()),
      content: Text('sign_in_required_dialog.message'.tr()),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close dialog
            Navigator.of(context).pop(); // Close current page
          },
          child: Text('sign_in_required_dialog.no'.tr()),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close dialog
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const SignInPage()),
            );
          },
          child: Text('sign_in_required_dialog.yes'.tr()),
        ),
      ],
    );
  }

  /// Show signin required dialog
  static Future<void> show(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SigninRequiredDialog();
      },
    );
  }
}
