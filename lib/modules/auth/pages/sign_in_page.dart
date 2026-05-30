import 'dart:io';

import 'package:template_app_flutter/configs/app_config.dart';
import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:template_app_flutter/core/utils/next_screen_util.dart';
import 'package:template_app_flutter/app/app_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:template_app_flutter/core/widgets/language/language_widget.dart';

import '../blocs/apple_provider_bloc.dart';
import '../blocs/apple_provider_event.dart';
import '../blocs/apple_provider_state.dart';
import '../blocs/auth_bloc.dart';
import '../blocs/auth_event.dart';
import '../blocs/auth_state.dart';
import '../blocs/google_provider_bloc.dart';
import '../blocs/google_provider_event.dart';
import '../blocs/google_provider_state.dart';
import '../models/user_firebase.dart';
import 'done_page.dart';

class SignInPage extends StatefulWidget {
  final String? tag;

  const SignInPage({super.key, this.tag});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool googleSignInStarted = false;
  bool appleSignInStarted = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<GoogleProviderBloc, GoogleProviderState>(
          listener: (context, state) {
            if (state is GoogleSignInLoading) {
              setState(() => googleSignInStarted = true);
            } else {
              setState(() => googleSignInStarted = false);
            }
            if (state is GoogleSignInSuccess) {
              handleSignIn(state.userFirebase);
            } else if (state is GoogleProviderFailure) {
              if (mounted) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.error)));
              }
            }
          },
        ),
        BlocListener<AppleProviderBloc, AppleProviderState>(
          listener: (context, state) {
            if (state is AppleSignInLoading) {
              setState(() => appleSignInStarted = true);
            } else {
              setState(() => appleSignInStarted = false);
            }
            if (state is AppleSignInSuccess) {
              handleSignIn(state.userFirebase);
            } else if (state is AppleProviderFailure) {
              if (mounted) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.error)));
                Text(state.error);
              }
            }
          },
        ),
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              afterSignIn();
            } else if (state is AuthFailure) {
              if (mounted) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.error)));
              }
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          actions: [
            widget.tag != null
                ? Container()
                : TextButton(
                    onPressed: () => handleSkip(),
                    child: Text(
                      'sign_in.skip'.tr(),
                      style: TextStyle(
                        fontSize: Theme.of(
                          context,
                        ).textTheme.bodyLarge?.fontSize,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? ThemeConfig.colorTextDarkPrimary
                            : ThemeConfig.colorTextLightPrimary,
                      ),
                    ),
                  ),

            IconButton(
              alignment: Alignment.center,
              padding: EdgeInsets.all(0),
              iconSize: 22,
              icon: Icon(Icons.language),
              onPressed: () {
                nextScreenPopup(context, LanguageWidget());
              },
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'sign_in.welcome_to'.tr(),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? ThemeConfig.colorTextDarkSecondary
                          : ThemeConfig.colorTextLightSecondary,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    AppConfig.appName,
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                      wordSpacing: 1,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? ThemeConfig.colorTextDarkPrimary
                          : ThemeConfig.colorTextLightPrimary,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right: 40),
                    child: Text(
                      'sign_in.welcome_message'.tr(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? ThemeConfig.colorTextDarkSecondary
                            : ThemeConfig.colorTextLightSecondary,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 2,
                    width: MediaQuery.of(context).size.width * 0.30,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.80,
                    child: TextButton(
                      onPressed: handleGoogleSignIn,
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.resolveWith(
                          (states) =>
                              Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey[100]
                              : Colors.white,
                        ),
                        side: WidgetStateProperty.resolveWith(
                          (states) => BorderSide(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? Colors.grey[700]!
                                : Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        shape: WidgetStateProperty.resolveWith(
                          (states) => RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      child: googleSignInStarted == false
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/logo/google_logo.webp',
                                  height: ThemeConfig.iconSizeBase,
                                ),
                                SizedBox(width: ThemeConfig.spacingSmall),
                                Text(
                                  'sign_in.sign_in_with_google'.tr(),
                                  style: Theme.of(context).textTheme.bodyLarge
                                      ?.copyWith(
                                        color:
                                            Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? ThemeConfig.colorTextDarkPrimary
                                            : ThemeConfig.colorTextLightPrimary,
                                      ),
                                ),
                              ],
                            )
                          : Center(child: CircularProgressIndicator()),
                    ),
                  ),
                  SizedBox(height: ThemeConfig.spacingSmall),
                  Platform.isAndroid
                      ? SizedBox()
                      : SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.80,
                          child: TextButton(
                            onPressed: handleAppleSignIn,
                            style: ButtonStyle(
                              backgroundColor: WidgetStateProperty.resolveWith(
                                (states) => Colors.grey[900],
                              ),
                              side: WidgetStateProperty.resolveWith(
                                (states) => BorderSide(
                                  color: ThemeConfig.colorGreyMedium,
                                  width: 1,
                                ),
                              ),
                              shape: WidgetStateProperty.resolveWith(
                                (states) => RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    ThemeConfig.spacingSmall,
                                  ),
                                ),
                              ),
                            ),
                            child: appleSignInStarted == false
                                ? Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        LineIcons.apple,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onPrimary,
                                        size: ThemeConfig.iconSizeExtraLarge,
                                      ),
                                      SizedBox(width: ThemeConfig.spacingSmall),
                                      Text(
                                        'sign_in.sign_in_with_apple'.tr(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              color: Theme.of(
                                                context,
                                              ).colorScheme.onPrimary,
                                            ),
                                      ),
                                    ],
                                  )
                                : Center(child: CircularProgressIndicator()),
                          ),
                        ),
                  SizedBox(height: ThemeConfig.spacingSmall),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void handleSkip() {
    // final sb = context.read<SignInBloc>();
    // sb.setGuestUser();
    nextScreen(context, DonePage());
  }

  void handleGoogleSignIn() {
    context.read<GoogleProviderBloc>().add(GoogleSignInRequested());
  }

  void handleAppleSignIn() {
    context.read<AppleProviderBloc>().add(AppleSignInRequested());
  }

  void handleSignIn(UserFirebase userFirebase) {
    context.read<AuthBloc>().add(AuthSignInRequested(userFirebase));
  }

  void afterSignIn() {
    if (widget.tag == null) {
      nextScreen(context, DonePage());
    } else {
      nextScreenReplace(context, AppPage());
    }
  }
}
