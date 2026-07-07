import 'package:flutter/material.dart';
import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:line_icons/line_icons.dart';

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const MenuItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: ThemeConfig.spacingBase,
      ),
      leading: Icon(icon),
      title: Text(title, style: Theme.of(context).textTheme.bodyMedium),
      trailing: Icon(LineIcons.angleRight),
      onTap: onTap,
    );
  }
}
