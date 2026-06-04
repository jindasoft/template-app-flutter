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

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  ThemeData _buildTheme({
    required Brightness brightness,
    required ColorScheme colorScheme,
    required TextTheme textTheme,
    required Color iconColor,
    required Color scaffoldBackgroundColor,
    required Color appBarBackgroundColor,
    required Color appBarTextColor,
    required Color inputFillColor,
    required Color inputBorderColor,
    required Color inputLabelColor,
    required Color inputHintColor,
    required Color bottomSheetAndCardBackgroundColor,
    required Color switchThumbColor,
    required Color switchTrackColor,
  }) {
    return ThemeData(
      useMaterial3: false,
      brightness: brightness,
      colorScheme: colorScheme,
      primaryColor: ThemeConfig.colorPrimary,
      textTheme: textTheme,
      iconTheme: IconThemeData(color: iconColor),
      fontFamily: 'Manrope',
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: appBarBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: iconColor),
        titleTextStyle: textTheme.titleLarge?.copyWith(color: appBarTextColor),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ThemeConfig.colorPrimary,
          foregroundColor: colorScheme.onPrimary,
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
        fillColor: inputFillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ThemeConfig.spacingMD),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ThemeConfig.spacingMD),
          borderSide: BorderSide(color: inputBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ThemeConfig.spacingMD),
          borderSide: BorderSide(color: ThemeConfig.colorPrimary),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: ThemeConfig.spacingLG,
          vertical: ThemeConfig.spacingMD,
        ),
        labelStyle: TextStyle(color: inputLabelColor),
        hintStyle: TextStyle(color: inputHintColor),
      ),
      dividerTheme: DividerThemeData(
        color: ThemeConfig.colorBorderDark,
        thickness: 1,
        space: ThemeConfig.spacingXS,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(switchThumbColor),
        trackColor: WidgetStateProperty.all(switchTrackColor),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: bottomSheetAndCardBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(ThemeConfig.spacingBase),
          ),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: bottomSheetAndCardBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ThemeConfig.spacingBase),
        ),
      ),
      cardTheme: CardThemeData(
        color: bottomSheetAndCardBackgroundColor,
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
        theme: _buildTheme(
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
          bottomSheetAndCardBackgroundColor: ThemeConfig.colorBgLightPrimary,
          switchThumbColor: ThemeConfig.colorGreyMedium,
          switchTrackColor: ThemeConfig.colorGreyMedium.withAlpha(
            (255 * 0.5).toInt(),
          ),
        ),
        darkTheme: _buildTheme(
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
          bottomSheetAndCardBackgroundColor: ThemeConfig.colorBgDarkPrimary,
          switchThumbColor: ThemeConfig.colorPrimary,
          switchTrackColor: ThemeConfig.colorPrimary.withAlpha(
            (255 * 0.5).toInt(),
          ),
        ),
        themeMode: themeNotifier.themeMode,
        home: AppPage(),
      ),
    );
  }
}
