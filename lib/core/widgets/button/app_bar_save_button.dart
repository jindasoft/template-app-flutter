import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppBarSaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AppBarSaveButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final button = OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text('app_bar.save'.tr()),
    );

    return Padding(padding: const EdgeInsets.all(8.0), child: button);
  }
}
