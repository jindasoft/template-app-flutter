import 'package:flutter/material.dart';

class ThemeConfig {
  // Font Sizes
  static const double fontSizeExtraSmall = 10;
  static const double fontSizeSmall = 14;
  static const double fontSizeMedium = 16;
  static const double fontSizeBase = 18;
  static const double fontSizeLarge = 20;
  static const double fontSizeExtraLarge = 24;
  static const double fontSizeHuge = 32;

  // Icon Sizes
  static const double iconSizeSmall = 16;
  static const double iconSizeMedium = 20;
  static const double iconSizeBase = 24;
  static const double iconSizeLarge = 28;
  static const double iconSizeExtraLarge = 32;

  // Colors - Primary
  static const Color colorPrimary = Color(0xFF007AFF);
  static const Color colorPrimaryDark = Color(0xFF0051D5);
  static const Color colorPrimaryLight = Color(0xFFB3D9FF);

  // Colors - Accent & Secondary
  static const Color colorAccent = Color(0xFF5AC8FA);
  static const Color colorSecondary = Color(0xFFFF2D55);

  // Colors - Neutral/Grey
  static const Color colorGreyLight = Color(0xFFF5F5F5);
  static const Color colorGreyMedium = Color(0xFF9CA3AF);
  static const Color colorGreyDark = Color(0xFF606060);

  // Colors - Status
  static const Color colorSuccess = Color(0xFF34C759);
  static const Color colorWarning = Color(0xFFFF9500);
  static const Color colorInfo = Color(0xFF5AC8FA);
  static const Color colorError = Color(0xFFFF3B30);
  static const Color colorDisabled = Color(0xFF9CA3AF);

  // Colors - Background
  static const Color colorBgLightPrimary = Color(0xFFFFFFFF);
  static const Color colorBgLightSecondary = Color(0xFFF2F2F7);
  static const Color colorBgDarkPrimary = Color(0xFF1E293B);
  static const Color colorBgDarkSecondary = Color(0xFF0F172A);

  // Colors - Border
  static const Color colorBorderDark = Color(0xFF374151);
  static const Color colorBorderLight = Color(0xFFD1D5DB);

  // Colors - Text
  static const Color colorTextLightPrimary = Color(0xFF000000);
  static const Color colorTextLightSecondary = Color(0xFF626262);
  static const Color colorTextDarkPrimary = Color(0xFFFFFFFF);
  static const Color colorTextDarkSecondary = Color(0xFFE0E0E0);

  // Text Theme - Light
  static TextTheme get lightTextTheme {
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: fontSizeHuge,
        fontWeight: FontWeight.w700,
        color: colorTextLightPrimary,
      ),
      displayMedium: TextStyle(
        fontSize: fontSizeExtraLarge,
        fontWeight: FontWeight.w700,
        color: colorTextLightPrimary,
      ),
      displaySmall: TextStyle(
        fontSize: fontSizeLarge,
        fontWeight: FontWeight.w600,
        color: colorTextLightPrimary,
      ),
      headlineMedium: TextStyle(
        fontSize: fontSizeBase,
        fontWeight: FontWeight.w600,
        color: colorTextLightPrimary,
      ),
      headlineSmall: TextStyle(
        fontSize: fontSizeMedium,
        fontWeight: FontWeight.w600,
        color: colorTextLightPrimary,
      ),
      titleLarge: TextStyle(
        fontSize: fontSizeBase,
        fontWeight: FontWeight.w600,
        color: colorTextLightPrimary,
      ),
      titleMedium: TextStyle(
        fontSize: fontSizeMedium,
        fontWeight: FontWeight.w500,
        color: colorTextLightPrimary,
      ),
      titleSmall: TextStyle(
        fontSize: fontSizeSmall,
        fontWeight: FontWeight.w500,
        color: colorTextLightPrimary,
      ),
      bodyLarge: TextStyle(
        fontSize: fontSizeBase,
        fontWeight: FontWeight.w400,
        color: colorTextLightPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: fontSizeMedium,
        fontWeight: FontWeight.w400,
        color: colorTextLightPrimary,
      ),
      bodySmall: TextStyle(
        fontSize: fontSizeSmall,
        fontWeight: FontWeight.w400,
        color: colorTextLightSecondary,
      ),
      labelLarge: TextStyle(
        fontSize: fontSizeSmall,
        fontWeight: FontWeight.w600,
        color: colorTextLightPrimary,
      ),
      labelMedium: TextStyle(
        fontSize: fontSizeExtraSmall,
        fontWeight: FontWeight.w500,
        color: colorTextLightSecondary,
      ),
      labelSmall: TextStyle(
        fontSize: fontSizeExtraSmall,
        fontWeight: FontWeight.w400,
        color: colorTextLightSecondary,
      ),
    );
  }

  // Text Theme - Dark
  static TextTheme get darkTextTheme {
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: fontSizeHuge,
        fontWeight: FontWeight.w700,
        color: colorTextDarkPrimary,
      ),
      displayMedium: TextStyle(
        fontSize: fontSizeExtraLarge,
        fontWeight: FontWeight.w700,
        color: colorTextDarkPrimary,
      ),
      displaySmall: TextStyle(
        fontSize: fontSizeLarge,
        fontWeight: FontWeight.w600,
        color: colorTextDarkPrimary,
      ),
      headlineMedium: TextStyle(
        fontSize: fontSizeBase,
        fontWeight: FontWeight.w600,
        color: colorTextDarkPrimary,
      ),
      headlineSmall: TextStyle(
        fontSize: fontSizeMedium,
        fontWeight: FontWeight.w600,
        color: colorTextDarkPrimary,
      ),
      titleLarge: TextStyle(
        fontSize: fontSizeBase,
        fontWeight: FontWeight.w600,
        color: colorTextDarkPrimary,
      ),
      titleMedium: TextStyle(
        fontSize: fontSizeMedium,
        fontWeight: FontWeight.w500,
        color: colorTextDarkPrimary,
      ),
      titleSmall: TextStyle(
        fontSize: fontSizeSmall,
        fontWeight: FontWeight.w500,
        color: colorTextDarkPrimary,
      ),
      bodyLarge: TextStyle(
        fontSize: fontSizeBase,
        fontWeight: FontWeight.w400,
        color: colorTextDarkPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: fontSizeMedium,
        fontWeight: FontWeight.w400,
        color: colorTextDarkPrimary,
      ),
      bodySmall: TextStyle(
        fontSize: fontSizeSmall,
        fontWeight: FontWeight.w400,
        color: colorTextDarkSecondary,
      ),
      labelLarge: TextStyle(
        fontSize: fontSizeSmall,
        fontWeight: FontWeight.w600,
        color: colorTextDarkPrimary,
      ),
      labelMedium: TextStyle(
        fontSize: fontSizeExtraSmall,
        fontWeight: FontWeight.w500,
        color: colorTextDarkSecondary,
      ),
      labelSmall: TextStyle(
        fontSize: fontSizeExtraSmall,
        fontWeight: FontWeight.w400,
        color: colorTextDarkSecondary,
      ),
    );
  }
}
