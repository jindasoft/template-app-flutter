import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:flutter/material.dart';

class CustomTextButtonGrey extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const CustomTextButtonGrey({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 0),
        minimumSize: const Size(0, 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: Theme.of(context).brightness == Brightness.dark
              ? ThemeConfig.colorTextDarkSecondary
              : ThemeConfig.colorTextLightSecondary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
