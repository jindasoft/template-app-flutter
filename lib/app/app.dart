import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template_app_flutter/configs/env_config.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template_app_flutter/core/notifiers/theme_notifier.dart';
import 'package:template_app_flutter/modules/auth/pages/sign_in_page.dart';
import 'package:template_app_flutter/modules/welcome/pages/welcome.dart';

import 'app_bloc_providers.dart';
import 'app_theme.dart';
import 'app_page.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  static const String _firstLaunchKey = 'first_launch';
  final bool _forceWelcomeForDev = EnvConfig.forceWelcomeEnabled;
  bool _isLoadingLaunchState = true;
  bool _isFirstLaunch = true;
  bool _devWelcomeDismissed = false;
  bool _showSignInAfterWelcome = false;

  @override
  void initState() {
    super.initState();
    _loadFirstLaunchState();
  }

  Future<void> _loadFirstLaunchState() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getBool(_firstLaunchKey);

    if (!mounted) {
      return;
    }

    setState(() {
      _isFirstLaunch = stored ?? true;
      _isLoadingLaunchState = false;
    });
  }

  Future<void> _completeFirstLaunch() async {
    if (!_forceWelcomeForDev) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_firstLaunchKey, false);
    }

    if (!mounted) {
      return;
    }

    setState(() {
      _isFirstLaunch = false;
      _devWelcomeDismissed = true;
      _showSignInAfterWelcome = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final lightPalette = AppTheme.buildLightPalette();
    final darkPalette = AppTheme.buildDarkPalette();
    final shouldShowWelcome =
        _isFirstLaunch || (_forceWelcomeForDev && !_devWelcomeDismissed);

    final home = _isLoadingLaunchState
        ? const Scaffold(body: Center(child: CircularProgressIndicator()))
        : shouldShowWelcome
        ? Welcome(onContinue: _completeFirstLaunch)
        : _showSignInAfterWelcome
        ? const SignInPage()
        : AppPage();

    return MultiBlocProvider(
      providers: buildAppBlocProviders(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        locale: context.locale,
        // navigatorObservers: [firebaseObserver],
        theme: AppTheme.buildTheme(lightPalette),
        darkTheme: AppTheme.buildTheme(darkPalette),
        themeMode: themeNotifier.themeMode,
        home: home,
      ),
    );
  }
}
