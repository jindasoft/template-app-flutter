import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:template_app_flutter/configs/text_theme_config.dart';
import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:template_app_flutter/core/notifiers/theme_notifier.dart';
import 'package:template_app_flutter/modules/auth/blocs/auth_bloc.dart';
import 'package:template_app_flutter/modules/auth/repositories/auth_repository.dart';

import 'app_page.dart';

class _ThemePalette {
  const _ThemePalette({
    required this.brightness,
    required this.colorScheme,
    required this.textTheme,
    required this.iconColor,
    required this.scaffoldBackgroundColor,
    required this.appBarBackgroundColor,
    required this.appBarTextColor,
    required this.inputFillColor,
    required this.inputBorderColor,
    required this.inputLabelColor,
    required this.inputHintColor,
    required this.surfaceColor,
    required this.switchThumbColor,
    required this.switchTrackColor,
  });

  final Brightness brightness;
  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final Color iconColor;
  final Color scaffoldBackgroundColor;
  final Color appBarBackgroundColor;
  final Color appBarTextColor;
  final Color inputFillColor;
  final Color inputBorderColor;
  final Color inputLabelColor;
  final Color inputHintColor;
  final Color surfaceColor;
  final Color switchThumbColor;
  final Color switchTrackColor;
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  ThemeData _buildTheme(_ThemePalette palette) {
    return ThemeData(
      useMaterial3: false,
      brightness: palette.brightness,
      colorScheme: palette.colorScheme,
      primaryColor: ThemeConfig.colorPrimary,
      textTheme: palette.textTheme,
      iconTheme: IconThemeData(color: palette.iconColor),
      fontFamily: 'Manrope',
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
          foregroundColor: palette.colorScheme.onPrimary,
          padding: EdgeInsets.all(ThemeConfig.spacingBase),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ThemeConfig.spacingMD),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: ThemeConfig.colorPrimary,
          side: BorderSide(color: ThemeConfig.colorPrimary),
          padding: EdgeInsets.all(ThemeConfig.spacingBase),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ThemeConfig.spacingMD),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: palette.inputFillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ThemeConfig.spacingMD),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ThemeConfig.spacingMD),
          borderSide: BorderSide(color: palette.inputBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ThemeConfig.spacingMD),
          borderSide: BorderSide(color: ThemeConfig.colorPrimary),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: ThemeConfig.spacingLG,
          vertical: ThemeConfig.spacingMD,
        ),
        labelStyle: TextStyle(color: palette.inputLabelColor),
        hintStyle: TextStyle(color: palette.inputHintColor),
      ),
      dividerTheme: DividerThemeData(
        color: ThemeConfig.colorBorderDark,
        thickness: 1,
        space: ThemeConfig.spacingXS,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(palette.switchThumbColor),
        trackColor: WidgetStateProperty.all(palette.switchTrackColor),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: palette.surfaceColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(ThemeConfig.spacingBase),
          ),
        ),
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

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final lightColorScheme = ColorScheme.fromSeed(
      seedColor: ThemeConfig.colorPrimary,
      brightness: Brightness.light,
    );
    final darkColorScheme = ColorScheme.fromSeed(
      seedColor: ThemeConfig.colorPrimary,
      brightness: Brightness.dark,
    );
    final lightPalette = _ThemePalette(
      brightness: Brightness.light,
      colorScheme: lightColorScheme,
      textTheme: TextThemeConfig.lightTextTheme,
      iconColor: ThemeConfig.colorGreyDark,
      scaffoldBackgroundColor: ThemeConfig.colorBgLightSecondary,
      appBarBackgroundColor: ThemeConfig.colorBgLightPrimary,
      appBarTextColor: ThemeConfig.colorTextLightPrimary,
      inputFillColor: ThemeConfig.colorGreyLight,
      inputBorderColor: ThemeConfig.colorBorderLight,
      inputLabelColor: ThemeConfig.colorTextLightPrimary,
      inputHintColor: ThemeConfig.colorTextLightSecondary,
      surfaceColor: ThemeConfig.colorBgLightPrimary,
      switchThumbColor: ThemeConfig.colorGreyMedium,
      switchTrackColor: ThemeConfig.colorGreyMedium.withAlpha(
        (255 * 0.5).toInt(),
      ),
    );
    final darkPalette = _ThemePalette(
      brightness: Brightness.dark,
      colorScheme: darkColorScheme,
      textTheme: TextThemeConfig.darkTextTheme,
      iconColor: ThemeConfig.colorGreyLight,
      scaffoldBackgroundColor: ThemeConfig.colorBgDarkSecondary,
      appBarBackgroundColor: ThemeConfig.colorBgDarkPrimary,
      appBarTextColor: ThemeConfig.colorTextDarkPrimary,
      inputFillColor: ThemeConfig.colorBgDarkPrimary,
      inputBorderColor: ThemeConfig.colorBorderDark,
      inputLabelColor: ThemeConfig.colorTextDarkPrimary,
      inputHintColor: ThemeConfig.colorTextDarkSecondary,
      surfaceColor: ThemeConfig.colorBgDarkPrimary,
      switchThumbColor: ThemeConfig.colorPrimary,
      switchTrackColor: ThemeConfig.colorPrimary.withAlpha((255 * 0.5).toInt()),
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(AuthRepository(context: context)),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        locale: context.locale,
        // navigatorObservers: [firebaseObserver],
        theme: _buildTheme(lightPalette),
        darkTheme: _buildTheme(darkPalette),
        themeMode: themeNotifier.themeMode,
        home: AppPage(),
      ),
    );
  }
}
