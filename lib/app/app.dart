import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:template_app_flutter/core/notifiers/theme_notifier.dart';
import 'package:template_app_flutter/core/utils/responsive_util.dart';
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
          textTheme: ThemeConfig.lightTextTheme,
          iconTheme: IconThemeData(color: ThemeConfig.colorGreyDark),
          fontFamily: 'Manrope',
          scaffoldBackgroundColor: ThemeConfig.colorLightBgSecondary,
          appBarTheme: AppBarTheme(
            backgroundColor: ThemeConfig.colorLightBgPrimary,
            elevation: 0,
            iconTheme: IconThemeData(color: ThemeConfig.colorGreyDark),
            titleTextStyle: TextStyle(
              fontSize: responsiveSize(context, ThemeConfig.fontSizeBase),
              fontWeight: FontWeight.w600,
              fontFamily: 'Manrope',
              color: ThemeConfig.colorLightTextPrimary,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: ThemeConfig.colorPrimary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              foregroundColor: ThemeConfig.colorPrimary,
              side: BorderSide(color: ThemeConfig.colorPrimary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: ThemeConfig.colorGreyLight,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          dividerTheme: DividerThemeData(
            color: ThemeConfig.colorGreyMedium,
            thickness: 1,
            space: 16,
          ),
        ),
        darkTheme: ThemeData(
          useMaterial3: false,
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
          primaryColor: ThemeConfig.colorPrimary,
          textTheme: ThemeConfig.darkTextTheme,
          iconTheme: IconThemeData(color: ThemeConfig.colorGreyLight),
          fontFamily: 'Manrope',
          scaffoldBackgroundColor: ThemeConfig.colorDarkBgSecondary,
          appBarTheme: AppBarTheme(
            backgroundColor: ThemeConfig.colorDarkBgPrimary,
            elevation: 0,
            iconTheme: IconThemeData(color: ThemeConfig.colorGreyLight),
            titleTextStyle: TextStyle(
              fontSize: responsiveSize(context, ThemeConfig.fontSizeBase),
              fontWeight: FontWeight.w600,
              fontFamily: 'Manrope',
              color: ThemeConfig.colorDarkTextPrimary,
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
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              foregroundColor: ThemeConfig.colorPrimary,
              side: BorderSide(color: ThemeConfig.colorPrimary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: ThemeConfig.colorDarkBgPrimary,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          dividerTheme: DividerThemeData(
            color: ThemeConfig.colorGreyDark,
            thickness: 1,
            space: 16,
          ),
        ),
        themeMode: themeNotifier.themeMode,
        home: AppPage(),
      ),
    );
  }
}
