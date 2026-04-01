import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppBarPostButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AppBarPostButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final button = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: ThemeConfig.colorPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 2.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text('app_bar.post'.tr()),
    );

    return Padding(padding: const EdgeInsets.all(8.0), child: button);
  }
}
