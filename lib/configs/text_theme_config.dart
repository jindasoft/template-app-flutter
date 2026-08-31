import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:template_app_flutter/configs/theme_config.dart';

class TextThemeConfig {
  static const List<String> _fontFamilyFallbacks = <String>[
    'Noto Sans Thai',
    'Noto Sans CJK SC',
    'Noto Sans CJK TC',
    'Noto Sans CJK JP',
    'Noto Sans CJK KR',
    'Noto Sans Arabic',
  ];

  // Text Theme - Light
  static TextTheme get lightTextTheme => _buildTextTheme(
    primaryColor: ThemeConfig.colorTextLightPrimary,
    secondaryColor: ThemeConfig.colorTextLightSecondary,
  );

  // Text Theme - Dark
  static TextTheme get darkTextTheme => _buildTextTheme(
    primaryColor: ThemeConfig.colorTextDarkPrimary,
    secondaryColor: ThemeConfig.colorTextDarkSecondary,
  );

  static TextTheme _buildTextTheme({
    required Color primaryColor,
    required Color secondaryColor,
  }) {
    final baseTheme = TextTheme(
      displayLarge: TextStyle(
        fontSize: ThemeConfig.fontSize36,
        fontWeight: FontWeight.w600,
        color: primaryColor,
      ),
      displayMedium: TextStyle(
        fontSize: ThemeConfig.fontSize28,
        fontWeight: FontWeight.w600,
        color: primaryColor,
      ),
      displaySmall: TextStyle(
        fontSize: ThemeConfig.fontSize24,
        fontWeight: FontWeight.w600,
        color: primaryColor,
      ),
      headlineLarge: TextStyle(
        fontSize: ThemeConfig.fontSize20,
        fontWeight: FontWeight.w600,
        color: primaryColor,
      ),
      headlineMedium: TextStyle(
        fontSize: ThemeConfig.fontSize18,
        fontWeight: FontWeight.w600,
        color: primaryColor,
      ),
      headlineSmall: TextStyle(
        fontSize: ThemeConfig.fontSize16,
        fontWeight: FontWeight.w600,
        color: primaryColor,
      ),
      titleLarge: TextStyle(
        fontSize: ThemeConfig.fontSize18,
        fontWeight: FontWeight.w600,
        color: primaryColor,
      ),
      titleMedium: TextStyle(
        fontSize: ThemeConfig.fontSize16,
        fontWeight: FontWeight.w500,
        color: primaryColor,
      ),
      titleSmall: TextStyle(
        fontSize: ThemeConfig.fontSize14,
        fontWeight: FontWeight.w500,
        color: primaryColor,
      ),
      bodyLarge: TextStyle(
        fontSize: ThemeConfig.fontSize18,
        fontWeight: FontWeight.w400,
        color: primaryColor,
      ),
      bodyMedium: TextStyle(
        fontSize: ThemeConfig.fontSize16,
        fontWeight: FontWeight.w400,
        color: primaryColor,
      ),
      bodySmall: TextStyle(
        fontSize: ThemeConfig.fontSize14,
        fontWeight: FontWeight.w400,
        color: secondaryColor,
      ),
      labelLarge: TextStyle(
        fontSize: ThemeConfig.fontSize14,
        fontWeight: FontWeight.w600,
        color: primaryColor,
      ),
      labelMedium: TextStyle(
        fontSize: ThemeConfig.fontSize12,
        fontWeight: FontWeight.w500,
        color: secondaryColor,
      ),
      labelSmall: TextStyle(
        fontSize: ThemeConfig.fontSize10,
        fontWeight: FontWeight.w400,
        color: secondaryColor,
      ),
    );

    return GoogleFonts.notoSansTextTheme(
      baseTheme,
    ).apply(fontFamilyFallback: _fontFamilyFallbacks);
  }
}
