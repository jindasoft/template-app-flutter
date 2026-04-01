import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:template_app_flutter/core/utils/responsive_util.dart';
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
        style: TextStyle(
          fontSize: responsiveSize(context, ThemeConfig.fontSizeBase),
          color: ThemeConfig.colorGreyDark,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
