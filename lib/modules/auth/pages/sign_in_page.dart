import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:template_app_flutter/core/language/language_sheet.dart';
import 'package:template_app_flutter/core/utils/next_screen_util.dart';
import 'package:template_app_flutter/app/app_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

import '../blocs/apple_provider_bloc.dart';
import '../blocs/apple_provider_event.dart';
import '../blocs/apple_provider_state.dart';
import '../blocs/auth_bloc.dart';
import '../blocs/auth_event.dart';
import '../blocs/auth_state.dart';
import '../blocs/firebase_bloc.dart';
import '../blocs/google_provider_bloc.dart';
import '../blocs/google_provider_event.dart';
import '../blocs/google_provider_state.dart';
import '../models/user_firebase.dart';
import '../repositories/provider_apple_repository.dart';
import '../repositories/provider_google_repository.dart';
import '../repositories/provider_repository.dart';
import '../widgets/sign_in_button_widget.dart';
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
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: _blocProvider(
          Builder(
            builder: (providerContext) {
              return _blocListener(_buildContent(providerContext));
            },
          ),
        ),
      ),
    );
  }

  Widget _blocProvider(Widget child) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FirebaseBloc(getProviderRepository()),
        ),
        BlocProvider(
          create: (context) => GoogleProviderBloc(ProviderGoogleRepository()),
        ),
        BlocProvider(
          create: (context) => AppleProviderBloc(ProviderAppleRepository()),
        ),
      ],
      child: child,
    );
  }

  Widget _blocListener(Widget child) {
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
              handleSignIn(context, state.userFirebase);
            } else if (state is GoogleSignInFailure) {
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
              handleSignIn(context, state.userFirebase);
            } else if (state is AppleSignInFailure) {
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
            if (state is AuthSignInSuccess) {
              afterSignIn();
            } else if (state is AuthSignInFailure) {
              if (mounted) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.error)));
              }
            }
          },
        ),
      ],
      child: child,
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: ThemeConfig.spacingBase,
            ),
          ),
          onPressed: () => showLanguageSheet(context),
          child: Row(
            children: [
              Icon(
                LineIcons.language,
                color: Theme.of(context).iconTheme.color,
              ),
              SizedBox(width: ThemeConfig.spacingXS),
              Text(
                'language.change_language'.tr(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'sign_in.welcome_to'.tr(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),

              Text(
                'app.title'.tr(),
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: ThemeConfig.spacingXS),

              Text(
                'app.subtitle'.tr(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),

        Flexible(
          flex: 2,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'app.tagline'.tr(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: ThemeConfig.spacingMD),
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width * 0.30,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: ThemeConfig.spacingXXL),
              ],
            ),
          ),
        ),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(ThemeConfig.spacingBase),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // google sign in
              SignInButtonWidget(
                onPressed: () => handleGoogleSignIn(context),
                isLoading: googleSignInStarted,
                backgroundColor: Colors.white,
                textColor: Colors.grey[900]!,
                label: 'sign_in.sign_in_with_google'.tr(),
                icon: Image.asset('assets/logo/google_logo.webp', height: 24),
              ),
              const SizedBox(height: ThemeConfig.spacingMD),

              // apple sign in
              Platform.isIOS
                  ? SignInButtonWidget(
                      onPressed: () => handleAppleSignIn(context),
                      isLoading: appleSignInStarted,
                      backgroundColor: Colors.grey[900]!,
                      textColor: Colors.grey[50]!,
                      label: 'sign_in.sign_in_with_apple'.tr(),
                      icon: Icon(
                        LineIcons.apple,
                        color: Colors.grey[50]!,
                        size: ThemeConfig.iconSizeExtraLarge,
                      ),
                    )
                  : SizedBox.shrink(),
              const SizedBox(height: ThemeConfig.spacingMD),

              // explore as guest
              TextButton(
                onPressed: handleSkip,
                child: Text(
                  'sign_in.explore_as_guest'.tr(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ThemeConfig.colorPrimaryLight,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void handleSkip() {
    // final sb = context.read<SignInBloc>();
    // sb.setGuestUser();
    nextScreen(context, DonePage());
  }

  void handleGoogleSignIn(BuildContext context) {
    context.read<GoogleProviderBloc>().add(GoogleSignInRequested());
  }

  void handleAppleSignIn(BuildContext context) {
    context.read<AppleProviderBloc>().add(AppleSignInRequested());
  }

  void handleSignIn(BuildContext context, UserFirebase userFirebase) {
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

ProviderRepository getProviderRepository() {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null && user.providerData.isNotEmpty) {
    final providerId = user.providerData.first.providerId;
    if (providerId == 'google.com') {
      return ProviderGoogleRepository();
    } else if (providerId == 'apple.com') {
      return ProviderAppleRepository();
    }
  }
  // fallback
  return ProviderGoogleRepository();
}
