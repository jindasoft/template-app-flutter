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
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 13,
              color: ThemeConfig.colorGreyDark,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 6),
          Icon(icon, size: 32, color: ThemeConfig.colorGreyDark),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: ThemeConfig.colorGreyDark,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
