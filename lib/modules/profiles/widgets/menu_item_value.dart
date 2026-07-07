import 'package:flutter/material.dart';
import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:line_icons/line_icons.dart';

class MenuItemValue extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final VoidCallback onTap;

  const MenuItemValue({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
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
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(value, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(width: 8),
          Icon(LineIcons.angleRight),
        ],
      ),
      onTap: onTap,
    );
  }
}
