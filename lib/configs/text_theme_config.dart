import 'package:flutter/material.dart';
import 'package:template_app_flutter/configs/theme_config.dart';

class TextThemeConfig {
  // Text Theme - Light
  static TextTheme get lightTextTheme {
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: ThemeConfig.fontSize32,
        fontWeight: FontWeight.w700,
        color: ThemeConfig.colorTextLightPrimary,
      ),
      displayMedium: TextStyle(
        fontSize: ThemeConfig.fontSize24,
        fontWeight: FontWeight.w700,
        color: ThemeConfig.colorTextLightPrimary,
      ),
      displaySmall: TextStyle(
        fontSize: ThemeConfig.fontSize20,
        fontWeight: FontWeight.w600,
        color: ThemeConfig.colorTextLightPrimary,
      ),
      headlineMedium: TextStyle(
        fontSize: ThemeConfig.fontSize18,
        fontWeight: FontWeight.w600,
        color: ThemeConfig.colorTextLightPrimary,
      ),
      headlineSmall: TextStyle(
        fontSize: ThemeConfig.fontSize16,
        fontWeight: FontWeight.w600,
        color: ThemeConfig.colorTextLightPrimary,
      ),
      titleLarge: TextStyle(
        fontSize: ThemeConfig.fontSize18,
        fontWeight: FontWeight.w600,
        color: ThemeConfig.colorTextLightPrimary,
      ),
      titleMedium: TextStyle(
        fontSize: ThemeConfig.fontSize16,
        fontWeight: FontWeight.w500,
        color: ThemeConfig.colorTextLightPrimary,
      ),
      titleSmall: TextStyle(
        fontSize: ThemeConfig.fontSize14,
        fontWeight: FontWeight.w500,
        color: ThemeConfig.colorTextLightPrimary,
      ),
      bodyLarge: TextStyle(
        fontSize: ThemeConfig.fontSize18,
        fontWeight: FontWeight.w400,
        color: ThemeConfig.colorTextLightPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: ThemeConfig.fontSize16,
        fontWeight: FontWeight.w400,
        color: ThemeConfig.colorTextLightPrimary,
      ),
      bodySmall: TextStyle(
        fontSize: ThemeConfig.fontSize14,
        fontWeight: FontWeight.w400,
        color: ThemeConfig.colorTextLightSecondary,
      ),
      labelLarge: TextStyle(
        fontSize: ThemeConfig.fontSize14,
        fontWeight: FontWeight.w600,
        color: ThemeConfig.colorTextLightPrimary,
      ),
      labelMedium: TextStyle(
        fontSize: ThemeConfig.fontSize12,
        fontWeight: FontWeight.w500,
        color: ThemeConfig.colorTextLightSecondary,
      ),
      labelSmall: TextStyle(
        fontSize: ThemeConfig.fontSize10,
        fontWeight: FontWeight.w400,
        color: ThemeConfig.colorTextLightSecondary,
      ),
    );
  }

  // Text Theme - Dark
  static TextTheme get darkTextTheme {
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: ThemeConfig.fontSize32,
        fontWeight: FontWeight.w700,
        color: ThemeConfig.colorTextDarkPrimary,
      ),
      displayMedium: TextStyle(
        fontSize: ThemeConfig.fontSize24,
        fontWeight: FontWeight.w700,
        color: ThemeConfig.colorTextDarkPrimary,
      ),
      displaySmall: TextStyle(
        fontSize: ThemeConfig.fontSize20,
        fontWeight: FontWeight.w600,
        color: ThemeConfig.colorTextDarkPrimary,
      ),
      headlineMedium: TextStyle(
        fontSize: ThemeConfig.fontSize18,
        fontWeight: FontWeight.w600,
        color: ThemeConfig.colorTextDarkPrimary,
      ),
      headlineSmall: TextStyle(
        fontSize: ThemeConfig.fontSize16,
        fontWeight: FontWeight.w600,
        color: ThemeConfig.colorTextDarkPrimary,
      ),
      titleLarge: TextStyle(
        fontSize: ThemeConfig.fontSize18,
        fontWeight: FontWeight.w600,
        color: ThemeConfig.colorTextDarkPrimary,
      ),
      titleMedium: TextStyle(
        fontSize: ThemeConfig.fontSize16,
        fontWeight: FontWeight.w500,
        color: ThemeConfig.colorTextDarkPrimary,
      ),
      titleSmall: TextStyle(
        fontSize: ThemeConfig.fontSize14,
        fontWeight: FontWeight.w500,
        color: ThemeConfig.colorTextDarkPrimary,
      ),
      bodyLarge: TextStyle(
        fontSize: ThemeConfig.fontSize18,
        fontWeight: FontWeight.w400,
        color: ThemeConfig.colorTextDarkPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: ThemeConfig.fontSize16,
        fontWeight: FontWeight.w400,
        color: ThemeConfig.colorTextDarkPrimary,
      ),
      bodySmall: TextStyle(
        fontSize: ThemeConfig.fontSize14,
        fontWeight: FontWeight.w400,
        color: ThemeConfig.colorTextDarkSecondary,
      ),
      labelLarge: TextStyle(
        fontSize: ThemeConfig.fontSize14,
        fontWeight: FontWeight.w600,
        color: ThemeConfig.colorTextDarkPrimary,
      ),
      labelMedium: TextStyle(
        fontSize: ThemeConfig.fontSize12,
        fontWeight: FontWeight.w500,
        color: ThemeConfig.colorTextDarkSecondary,
      ),
      labelSmall: TextStyle(
        fontSize: ThemeConfig.fontSize10,
        fontWeight: FontWeight.w400,
        color: ThemeConfig.colorTextDarkSecondary,
      ),
    );
  }
}
