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
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

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
        theme: ThemeData(
          useMaterial3: false,
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          primaryColor: ThemeConfig.colorPrimary,
          textTheme: TextThemeConfig.lightTextTheme,
          iconTheme: IconThemeData(color: ThemeConfig.colorGreyDark),
          fontFamily: 'Manrope',
          scaffoldBackgroundColor: ThemeConfig.colorBgLightSecondary,
          appBarTheme: AppBarTheme(
            backgroundColor: ThemeConfig.colorBgLightPrimary,
            elevation: 0,
            iconTheme: IconThemeData(color: ThemeConfig.colorGreyDark),
            titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: ThemeConfig.colorTextLightPrimary,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: ThemeConfig.colorPrimary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(ThemeConfig.spacingMedium),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: ThemeConfig.spacingLarge,
                vertical: ThemeConfig.spacingMedium,
              ),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              foregroundColor: ThemeConfig.colorPrimary,
              side: BorderSide(color: ThemeConfig.colorPrimary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(ThemeConfig.spacingMedium),
              ),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: ThemeConfig.colorBgLightPrimary,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ThemeConfig.spacingMedium),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ThemeConfig.spacingMedium),
              borderSide: BorderSide(color: ThemeConfig.colorBorderLight),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ThemeConfig.spacingMedium),
              borderSide: BorderSide(color: ThemeConfig.colorPrimary),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: ThemeConfig.spacingLarge,
              vertical: ThemeConfig.spacingMedium,
            ),
            hintStyle: TextStyle(color: ThemeConfig.colorGreyMedium),
            labelStyle: TextStyle(color: ThemeConfig.colorTextLightSecondary),
          ),
          dividerTheme: DividerThemeData(
            color: ThemeConfig.colorGreyMedium,
            thickness: 1,
            space: ThemeConfig.spacingLarge,
          ),
          switchTheme: SwitchThemeData(
            thumbColor: WidgetStateProperty.all(ThemeConfig.colorGreyMedium),
            trackColor: WidgetStateProperty.all(
              ThemeConfig.colorGreyMedium.withAlpha((255 * 0.5).toInt()),
            ),
          ),
          bottomSheetTheme: BottomSheetThemeData(
            backgroundColor: ThemeConfig.colorBgLightPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(ThemeConfig.spacingBase),
              ),
            ),
          ),
          dialogTheme: DialogThemeData(
            backgroundColor: ThemeConfig.colorBgLightPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ThemeConfig.spacingBase),
            ),
          ),
          cardTheme: CardThemeData(
            color: ThemeConfig.colorBgLightPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ThemeConfig.spacingBase),
            ),
          ),
        ),
        darkTheme: ThemeData(
          useMaterial3: false,
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
          primaryColor: ThemeConfig.colorPrimary,
          textTheme: TextThemeConfig.darkTextTheme,
          iconTheme: IconThemeData(color: ThemeConfig.colorGreyLight),
          fontFamily: 'Manrope',
          scaffoldBackgroundColor: ThemeConfig.colorBgDarkSecondary,
          appBarTheme: AppBarTheme(
            backgroundColor: ThemeConfig.colorBgDarkPrimary,
            elevation: 0,
            iconTheme: IconThemeData(color: ThemeConfig.colorGreyLight),
            titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: ThemeConfig.colorTextDarkPrimary,
            ),
          ),
          switchTheme: SwitchThemeData(
            thumbColor: WidgetStateProperty.all(ThemeConfig.colorPrimary),
            trackColor: WidgetStateProperty.all(
              ThemeConfig.colorPrimary.withAlpha((255 * 0.5).toInt()),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: ThemeConfig.colorPrimary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(ThemeConfig.spacingMedium),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: ThemeConfig.spacingLarge,
                vertical: ThemeConfig.spacingMedium,
              ),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              foregroundColor: ThemeConfig.colorPrimary,
              side: BorderSide(color: ThemeConfig.colorPrimary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(ThemeConfig.spacingMedium),
              ),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: ThemeConfig.colorBgDarkPrimary,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ThemeConfig.spacingMedium),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ThemeConfig.spacingMedium),
              borderSide: BorderSide(color: ThemeConfig.colorBorderDark),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(ThemeConfig.spacingMedium),
              borderSide: BorderSide(color: ThemeConfig.colorPrimary),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: ThemeConfig.spacingLarge,
              vertical: ThemeConfig.spacingMedium,
            ),
            hintStyle: TextStyle(color: ThemeConfig.colorGreyMedium),
            labelStyle: TextStyle(color: ThemeConfig.colorTextDarkSecondary),
          ),
          dividerTheme: DividerThemeData(
            color: ThemeConfig.colorGreyDark,
            thickness: 1,
            space: ThemeConfig.spacingLarge,
          ),
          bottomSheetTheme: BottomSheetThemeData(
            backgroundColor: ThemeConfig.colorBgDarkPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(ThemeConfig.spacingBase),
              ),
            ),
          ),
          dialogTheme: DialogThemeData(
            backgroundColor: ThemeConfig.colorBgDarkPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ThemeConfig.spacingBase),
            ),
          ),
          cardTheme: CardThemeData(
            color: ThemeConfig.colorBgDarkPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ThemeConfig.spacingBase),
            ),
          ),
        ),
        themeMode: themeNotifier.themeMode,
        home: AppPage(),
      ),
    );
  }
}
