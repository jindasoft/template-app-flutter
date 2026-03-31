import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:template_app_flutter/core/utils/responsive_util.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const CustomElevatedButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        backgroundColor: ThemeConfig.colorPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: responsiveSize(context, ThemeConfig.fontSizeBase),
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
