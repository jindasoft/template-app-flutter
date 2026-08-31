import 'package:flutter/material.dart';
import 'package:template_app_flutter/configs/text_theme_config.dart';
import 'package:template_app_flutter/configs/theme_config.dart';

class AppTheme {
  static const List<String> _fontFamilyFallbacks = <String>[
    'Noto Sans Thai',
    'Noto Sans CJK SC',
    'Noto Sans CJK TC',
    'Noto Sans CJK JP',
    'Noto Sans CJK KR',
    'Noto Sans Arabic',
  ];

  static ThemeData buildTheme(ThemePalette palette) {
    return ThemeData(
      useMaterial3: false,
      brightness: palette.brightness,
      colorScheme: palette.colorScheme,
      primaryColor: ThemeConfig.colorPrimary,
      textTheme: palette.textTheme,
      iconTheme: IconThemeData(color: palette.iconColor),
      fontFamily: 'Noto Sans',
      fontFamilyFallback: _fontFamilyFallbacks,
      scaffoldBackgroundColor: palette.scaffoldBackgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: palette.appBarBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: palette.iconColor),
        titleTextStyle: palette.textTheme.titleLarge?.copyWith(
          color: palette.appBarTextColor,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ThemeConfig.colorPrimary,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: ThemeConfig.spacingLG,
            vertical: ThemeConfig.spacingMD,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ThemeConfig.spacingMD),
          ),
          textStyle: palette.textTheme.titleMedium,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: ThemeConfig.colorPrimary,
          side: BorderSide(color: ThemeConfig.colorPrimary),
          padding: EdgeInsets.symmetric(
            horizontal: ThemeConfig.spacingLG,
            vertical: ThemeConfig.spacingMD,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ThemeConfig.spacingMD),
          ),
          textStyle: palette.textTheme.titleMedium,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: ThemeConfig.spacingLG,
            vertical: ThemeConfig.spacingMD,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ThemeConfig.spacingMD),
          ),
          textStyle: palette.textTheme.titleMedium,
        ),
      ),
      dividerTheme: DividerThemeData(color: palette.dividerColor, thickness: 1),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(ThemeConfig.colorGreyMedium),
        trackColor: WidgetStateProperty.all(
          ThemeConfig.colorGreyMedium.withAlpha((255 * 0.5).toInt()),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        showDragHandle: true,
        backgroundColor: palette.surfaceColor,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(ThemeConfig.spacingBase),
          ),
        ),
      ),
      bottomAppBarTheme: BottomAppBarThemeData(
        color: palette.surfaceColor,
        elevation: 4,
        shape: CircularNotchedRectangle(),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: palette.surfaceColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ThemeConfig.spacingBase),
        ),
      ),
      cardTheme: CardThemeData(
        color: palette.surfaceColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ThemeConfig.spacingBase),
        ),
      ),
    );
  }

  static ThemePalette buildLightPalette() {
    final lightColorScheme = ColorScheme.fromSeed(
      seedColor: ThemeConfig.colorPrimary,
      brightness: Brightness.light,
    ).copyWith(surface: ThemeConfig.colorBgLightPrimary);

    return ThemePalette(
      brightness: Brightness.light,
      colorScheme: lightColorScheme,
      textTheme: TextThemeConfig.lightTextTheme,
      iconColor: ThemeConfig.colorGreyDark,
      scaffoldBackgroundColor: ThemeConfig.colorBgLightSecondary,
      appBarBackgroundColor: ThemeConfig.colorBgLightPrimary,
      appBarTextColor: ThemeConfig.colorTextLightPrimary,
      surfaceColor: lightColorScheme.surface,
      dividerColor: ThemeConfig.colorBorderLight,
    );
  }

  static ThemePalette buildDarkPalette() {
    final darkColorScheme = ColorScheme.fromSeed(
      seedColor: ThemeConfig.colorPrimary,
      brightness: Brightness.dark,
    ).copyWith(surface: ThemeConfig.colorBgDarkPrimary);

    return ThemePalette(
      brightness: Brightness.dark,
      colorScheme: darkColorScheme,
      textTheme: TextThemeConfig.darkTextTheme,
      iconColor: ThemeConfig.colorGreyLight,
      scaffoldBackgroundColor: ThemeConfig.colorBgDarkSecondary,
      appBarBackgroundColor: ThemeConfig.colorBgDarkPrimary,
      appBarTextColor: ThemeConfig.colorTextDarkPrimary,
      surfaceColor: darkColorScheme.surface,
      dividerColor: ThemeConfig.colorBorderDark,
    );
  }
}

class ThemePalette {
  const ThemePalette({
    required this.brightness,
    required this.colorScheme,
    required this.textTheme,
    required this.iconColor,
    required this.scaffoldBackgroundColor,
    required this.appBarBackgroundColor,
    required this.appBarTextColor,
    required this.surfaceColor,
    required this.dividerColor,
  });

  final Brightness brightness;
  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final Color iconColor;
  final Color scaffoldBackgroundColor;
  final Color appBarBackgroundColor;
  final Color appBarTextColor;
  final Color surfaceColor;
  final Color dividerColor;
}
