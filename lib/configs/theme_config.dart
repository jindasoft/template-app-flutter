import 'package:flutter/material.dart';

class ThemeConfig {
  // Font Sizes
  static const double fontSizeExtraSmall = 12;
  static const double fontSizeSmall = 14;
  static const double fontSizeMedium = 16;
  static const double fontSizeBase = 18;
  static const double fontSizeLarge = 22;
  static const double fontSizeExtraLarge = 26;
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
  static const Color colorGreyLight = Color(0xFFEEEEEE);
  static const Color colorGreyMedium = Color(0xFFBDBDBD);
  static const Color colorGreyDark = Color(0xFF616161);
  static const Color colorTextGrey = Color(0xFF9E9E9E);

  // Colors - Status
  static const Color colorSuccess = Color(0xFF34C759);
  static const Color colorWarning = Color(0xFFFF9500);
  static const Color colorInfo = Color(0xFF5AC8FA);
  static const Color colorError = Color(0xFFFF3B30);

  // Colors - Background & Text
  static const Color colorLightBgPrimary = Color(0xFFFFFFFF);
  static const Color colorLightBgSecondary = Color(0xFFF2F2F7);
  static const Color colorLightTextPrimary = Color(0xFF000000);
  static const Color colorLightTextSecondary = Color(0xFF626262);
  static const Color colorDarkBgPrimary = Color(0xFF1E293B);
  static const Color colorDarkBgSecondary = Color(0xFF0F172A);
  static const Color colorDarkTextPrimary = Color(0xFFFFFFFF);
  static const Color colorDarkTextSecondary = Color(0xFFE0E0E0);

  // Text Theme - Light
  static TextTheme get lightTextTheme {
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: fontSizeHuge,
        fontWeight: FontWeight.w700,
        color: colorLightTextPrimary,
      ),
      displayMedium: TextStyle(
        fontSize: fontSizeExtraLarge,
        fontWeight: FontWeight.w700,
        color: colorLightTextPrimary,
      ),
      displaySmall: TextStyle(
        fontSize: fontSizeLarge,
        fontWeight: FontWeight.w600,
        color: colorLightTextPrimary,
      ),
      headlineMedium: TextStyle(
        fontSize: fontSizeBase,
        fontWeight: FontWeight.w600,
        color: colorLightTextPrimary,
      ),
      headlineSmall: TextStyle(
        fontSize: fontSizeMedium,
        fontWeight: FontWeight.w600,
        color: colorLightTextPrimary,
      ),
      titleLarge: TextStyle(
        fontSize: fontSizeBase,
        fontWeight: FontWeight.w600,
        color: colorLightTextPrimary,
      ),
      titleMedium: TextStyle(
        fontSize: fontSizeMedium,
        fontWeight: FontWeight.w500,
        color: colorLightTextPrimary,
      ),
      titleSmall: TextStyle(
        fontSize: fontSizeSmall,
        fontWeight: FontWeight.w500,
        color: colorLightTextPrimary,
      ),
      bodyLarge: TextStyle(
        fontSize: fontSizeBase,
        fontWeight: FontWeight.w400,
        color: colorLightTextPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: fontSizeMedium,
        fontWeight: FontWeight.w400,
        color: colorLightTextPrimary,
      ),
      bodySmall: TextStyle(
        fontSize: fontSizeSmall,
        fontWeight: FontWeight.w400,
        color: colorLightTextSecondary,
      ),
      labelLarge: TextStyle(
        fontSize: fontSizeSmall,
        fontWeight: FontWeight.w600,
        color: colorLightTextPrimary,
      ),
      labelMedium: TextStyle(
        fontSize: fontSizeExtraSmall,
        fontWeight: FontWeight.w500,
        color: colorLightTextSecondary,
      ),
      labelSmall: TextStyle(
        fontSize: fontSizeExtraSmall,
        fontWeight: FontWeight.w400,
        color: colorLightTextSecondary,
      ),
    );
  }

  // Text Theme - Dark
  static TextTheme get darkTextTheme {
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: fontSizeHuge,
        fontWeight: FontWeight.w700,
        color: colorDarkTextPrimary,
      ),
      displayMedium: TextStyle(
        fontSize: fontSizeExtraLarge,
        fontWeight: FontWeight.w700,
        color: colorDarkTextPrimary,
      ),
      displaySmall: TextStyle(
        fontSize: fontSizeLarge,
        fontWeight: FontWeight.w600,
        color: colorDarkTextPrimary,
      ),
      headlineMedium: TextStyle(
        fontSize: fontSizeBase,
        fontWeight: FontWeight.w600,
        color: colorDarkTextPrimary,
      ),
      headlineSmall: TextStyle(
        fontSize: fontSizeMedium,
        fontWeight: FontWeight.w600,
        color: colorDarkTextPrimary,
      ),
      titleLarge: TextStyle(
        fontSize: fontSizeBase,
        fontWeight: FontWeight.w600,
        color: colorDarkTextPrimary,
      ),
      titleMedium: TextStyle(
        fontSize: fontSizeMedium,
        fontWeight: FontWeight.w500,
        color: colorDarkTextPrimary,
      ),
      titleSmall: TextStyle(
        fontSize: fontSizeSmall,
        fontWeight: FontWeight.w500,
        color: colorDarkTextPrimary,
      ),
      bodyLarge: TextStyle(
        fontSize: fontSizeBase,
        fontWeight: FontWeight.w400,
        color: colorDarkTextPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: fontSizeMedium,
        fontWeight: FontWeight.w400,
        color: colorDarkTextPrimary,
      ),
      bodySmall: TextStyle(
        fontSize: fontSizeSmall,
        fontWeight: FontWeight.w400,
        color: colorDarkTextSecondary,
      ),
      labelLarge: TextStyle(
        fontSize: fontSizeSmall,
        fontWeight: FontWeight.w600,
        color: colorDarkTextPrimary,
      ),
      labelMedium: TextStyle(
        fontSize: fontSizeExtraSmall,
        fontWeight: FontWeight.w500,
        color: colorDarkTextSecondary,
      ),
      labelSmall: TextStyle(
        fontSize: fontSizeExtraSmall,
        fontWeight: FontWeight.w400,
        color: colorDarkTextSecondary,
      ),
    );
  }
}
