import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:flutter/material.dart';

class InfoItemButtonWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onPressed;

  const InfoItemButtonWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: ThemeConfig.spacingSM,
          vertical: ThemeConfig.spacingXS,
        ),
        child: Column(
          children: [
            Text(
              title.toUpperCase(),
              strutStyle: const StrutStyle(forceStrutHeight: true),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: ThemeConfig.spacingXS),
            Icon(
              icon,
              size: ThemeConfig.iconSizeLarge,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: ThemeConfig.spacingXS),
            Text(
              subtitle,
              strutStyle: const StrutStyle(forceStrutHeight: true),
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
