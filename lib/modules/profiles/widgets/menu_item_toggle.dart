import 'package:flutter/material.dart';
import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:template_app_flutter/core/widgets/fields/switch_list_tile_field_widget.dart';

class MenuItemToggle extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function(bool) onChanged;

  const MenuItemToggle({
    super.key,
    required this.icon,
    required this.title,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTileFieldWidget(
      title: title,
      titleTextStyle: Theme.of(context).textTheme.bodyMedium,
      value: Theme.of(context).brightness == Brightness.dark,
      onChanged: (value) {
        onChanged(value);
      },
      secondary: Icon(icon),
      controlAffinity: ListTileControlAffinity.trailing,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: ThemeConfig.spacingBase,
      ),
    );
  }
}
