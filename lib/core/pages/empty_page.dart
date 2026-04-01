import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:template_app_flutter/core/utils/responsive_util.dart';
import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  final IconData icon;
  final String message;
  final String description;

  const EmptyPage({
    super.key,
    required this.icon,
    required this.message,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 100, color: ThemeConfig.colorGreyMedium),
          SizedBox(height: 20),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: responsiveSize(context, ThemeConfig.fontSizeLarge),
              fontWeight: FontWeight.w500,
              color: ThemeConfig.colorGreyDark,
            ),
          ),
          SizedBox(height: 5),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: responsiveSize(context, ThemeConfig.fontSizeBase),
              fontWeight: FontWeight.w400,
              color: ThemeConfig.colorGreyDark,
            ),
          ),
        ],
      ),
    );
  }
}
