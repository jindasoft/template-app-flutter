import 'package:flutter/material.dart';
import 'package:template_app_flutter/configs/theme_config.dart';

class SwitchListTileFieldWidget extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color? activeThumbColor;
  final Color? activeTrackColor;
  final EdgeInsets contentPadding;
  final Widget? secondary;
  final ListTileControlAffinity? controlAffinity;
  final TextStyle? titleTextStyle;

  const SwitchListTileFieldWidget({
    super.key,
    required this.title,
    this.subtitle,
    required this.value,
    required this.onChanged,
    this.activeThumbColor,
    this.activeTrackColor,
    this.contentPadding = EdgeInsets.zero,
    this.secondary,
    this.controlAffinity,
    this.titleTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      activeThumbColor: activeThumbColor ?? ThemeConfig.colorPrimary,
      activeTrackColor:
          activeTrackColor ?? ThemeConfig.colorPrimary.withValues(alpha: 0.5),
      contentPadding: contentPadding,
      secondary: secondary,
      controlAffinity: controlAffinity,
      title: Text(title, style: titleTextStyle),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      value: value,
      onChanged: onChanged,
    );
  }
}
