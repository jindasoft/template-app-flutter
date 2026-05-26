import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:flutter/material.dart';

class InfoItemButtonWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final String value;
  final VoidCallback onPressed;

  const InfoItemButtonWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.value,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).brightness == Brightness.dark
        ? ThemeConfig.colorDarkTextPrimary
        : ThemeConfig.colorLightTextPrimary;
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 13,
              color: textColor,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 6),
          Icon(icon, size: 32, color: textColor),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
