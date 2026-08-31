import 'package:flutter/material.dart';
import 'package:template_app_flutter/configs/theme_config.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final int? maxLines;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final bool hasError;

  const TextFieldWidget({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
    this.maxLines = 1,
    this.keyboardType,
    this.onChanged,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        hintText: hint,
        hintStyle: TextStyle(color: ThemeConfig.colorGreyMedium),
        prefixIcon: Icon(icon, color: ThemeConfig.colorPrimary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ThemeConfig.spacingMD),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ThemeConfig.spacingMD),
          borderSide: BorderSide(
            color: hasError
                ? Theme.of(context).colorScheme.error
                : Theme.of(context).dividerColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ThemeConfig.spacingMD),
          borderSide: BorderSide(
            color: hasError
                ? Theme.of(context).colorScheme.error
                : ThemeConfig.colorPrimary,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: ThemeConfig.spacingLG,
          vertical: ThemeConfig.spacingSM,
        ),
        labelStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
      ),
    );
  }
}
