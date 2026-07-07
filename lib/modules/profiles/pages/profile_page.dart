import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template_app_flutter/core/utils/next_screen_util.dart';
import 'package:template_app_flutter/modules/auth/pages/sign_in_page.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:template_app_flutter/core/notifiers/theme_notifier.dart';
import 'package:template_app_flutter/core/language/language_sheet.dart';
import 'package:template_app_flutter/modules/auth/blocs/auth_bloc.dart';
import 'package:template_app_flutter/modules/auth/blocs/auth_state.dart';

import '../widgets/menu_item.dart';
import '../widgets/menu_item_value.dart';
import '../widgets/menu_item_toggle.dart';
import 'account_page.dart';
import 'info_page.dart';
import 'profile_image_page.dart';

enum _MenuVisibility { all, authOnly, guestOnly }

class _MenuConfig {
  final _MenuVisibility visibility;
  final Widget Function(BuildContext context) builder;

  const _MenuConfig({required this.visibility, required this.builder});
}

class ProfilePage extends StatefulWidget {
  final File? initialImage;

  const ProfilePage({super.key, this.initialImage});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(context), body: _buildBody(context));
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(title: Text('profile.title'.tr()), centerTitle: true);
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final isLoggedIn = context.read<AuthBloc>().isSignedIn;
        return _buildContent(context, isLoggedIn);
      },
    );
  }

  Widget _buildContent(BuildContext context, bool isLoggedIn) {
    final accountItems = _buildVisibleMenuItems(
      context,
      _accountMenuConfigs(),
      isLoggedIn,
    );
    final settingItems = _buildVisibleMenuItems(
      context,
      _settingMenuConfigs(context),
      isLoggedIn,
    );

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile header
          _buildProfileHeader(context, isLoggedIn),

          // Account Information section
          if (accountItems.isNotEmpty) ...[
            _buildSection(
              context: context,
              title: 'account.title'.tr(),
              items: accountItems,
            ),
            const SizedBox(height: ThemeConfig.spacingBase),
          ],

          // Settings section
          _buildSection(
            context: context,
            title: 'setting.title'.tr(),
            items: settingItems,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, bool isLoggedIn) {
    return isLoggedIn ? _buildUserHeader(context) : _buildGuestHeader(context);
  }

  Widget _buildUserHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(ThemeConfig.spacingBase),
      child: Row(
        children: [
          // Avatar
          Container(
            decoration: const BoxDecoration(
              color: ThemeConfig.colorPrimary,
              shape: BoxShape.circle,
            ),
            child: GestureDetector(
              onTap: () {
                nextScreen(context, ProfileImagePage(avatarUrl: ''));
              },
              child: CircleAvatar(
                radius: 40,
                backgroundColor: ThemeConfig.colorPrimary,
                child: Icon(
                  LineIcons.user,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? ThemeConfig.colorTextDarkPrimary
                      : Colors.white,
                  size: ThemeConfig.iconSizeLarge,
                ),
              ),
            ),
          ),
          const SizedBox(width: ThemeConfig.spacingBase),

          // User info
          Expanded(
            child: GestureDetector(
              onTap: () {
                nextScreen(context, const AccountPage());
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ThunderDuck',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: ThemeConfig.spacingXXS),
                  Text(
                    'JID: 123-4567-8900',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? ThemeConfig.colorTextDarkSecondary
                          : ThemeConfig.colorTextLightSecondary,
                    ),
                  ),
                  const SizedBox(height: ThemeConfig.spacingMD),

                  // bio
                  Text(
                    'profile.no_bio'.tr(),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGuestHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(ThemeConfig.spacingBase),
      margin: const EdgeInsets.all(ThemeConfig.spacingBase),
      decoration: BoxDecoration(
        border: Border.all(color: ThemeConfig.colorGreyMedium),
        borderRadius: BorderRadius.circular(ThemeConfig.spacingBase),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'account.guest'.tr(),
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: ThemeConfig.spacingXXS),
          Text(
            'account.guest_welcome'.tr(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).brightness == Brightness.dark
                  ? ThemeConfig.colorTextDarkSecondary
                  : ThemeConfig.colorTextLightSecondary,
            ),
          ),
          const SizedBox(height: ThemeConfig.spacingBase),

          ElevatedButton(
            onPressed: () {
              nextScreenPopup(context, const SignInPage());
            },
            child: Text('account.sign_in'.tr()),
          ),
        ],
      ),
    );
  }

  List<_MenuConfig> _accountMenuConfigs() {
    return [
      _MenuConfig(
        visibility: _MenuVisibility.authOnly,
        builder: (context) => MenuItem(
          icon: LineIcons.user,
          title: 'account.my_account'.tr(),
          onTap: () {
            nextScreen(context, const AccountPage());
          },
        ),
      ),
    ];
  }

  List<_MenuConfig> _settingMenuConfigs(BuildContext context) {
    return [
      _MenuConfig(
        visibility: _MenuVisibility.all,
        builder: (context) => MenuItemToggle(
          icon: Theme.of(context).brightness == Brightness.dark
              ? LineIcons.moon
              : LineIcons.sun,
          title: 'setting.dark_mode'.tr(),
          onChanged: (value) {
            final themeNotifier = Provider.of<ThemeNotifier>(
              context,
              listen: false,
            );
            themeNotifier.setTheme(value ? ThemeMode.dark : ThemeMode.light);
          },
        ),
      ),
      _MenuConfig(
        visibility: _MenuVisibility.all,
        builder: (context) => MenuItemValue(
          icon: LineIcons.language,
          title: 'language.title'.tr(),
          value: context.locale.languageCode == 'th' ? 'TH' : 'EN',
          onTap: () => showLanguageSheet(context),
        ),
      ),
      _MenuConfig(
        visibility: _MenuVisibility.all,
        builder: (context) => MenuItem(
          icon: LineIcons.info,
          title: 'info.title'.tr(),
          onTap: () {
            nextScreen(context, const InfoPage());
          },
        ),
      ),
      _MenuConfig(
        visibility: _MenuVisibility.authOnly,
        builder: (context) => MenuItem(
          icon: LineIcons.alternateSignOut,
          title: 'account.sign_out'.tr(),
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => _signOutDialog(context),
            );
          },
        ),
      ),
    ];
  }

  List<Widget> _buildVisibleMenuItems(
    BuildContext context,
    List<_MenuConfig> configs,
    bool isLoggedIn,
  ) {
    return configs
        .where((config) => _canShowMenu(config.visibility, isLoggedIn))
        .map((config) => config.builder(context))
        .toList();
  }

  bool _canShowMenu(_MenuVisibility visibility, bool isLoggedIn) {
    switch (visibility) {
      case _MenuVisibility.all:
        return true;
      case _MenuVisibility.authOnly:
        return isLoggedIn;
      case _MenuVisibility.guestOnly:
        return !isLoggedIn;
    }
  }

  Widget _buildSection({
    required BuildContext context,
    required String title,
    required List<Widget> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(ThemeConfig.spacingBase),
          child: Text(title, style: Theme.of(context).textTheme.titleMedium),
        ),
        ...List.generate(
          items.length,
          (index) => Column(
            children: [
              items[index],
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: ThemeConfig.spacingBase,
                ),
                child: Divider(height: ThemeConfig.spacingXS),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _signOutDialog(BuildContext context) {
    return AlertDialog(
      title: Text('account.sign_out'.tr()),
      content: Text('account.sign_out_confirmation'.tr()),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('common.cancel'.tr()),
        ),
        TextButton(
          onPressed: () {
            // Perform sign out logic here
            Navigator.of(context).pop();
          },
          child: Text('common.confirm'.tr()),
        ),
      ],
    );
  }
}
