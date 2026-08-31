import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:template_app_flutter/app/app_page.dart';
import 'package:template_app_flutter/core/enums/image_size.dart';
import 'package:template_app_flutter/core/services/private_api.dart';
import 'package:template_app_flutter/core/utils/next_screen_util.dart';
import 'package:template_app_flutter/core/widgets/loading/loading_widget.dart';
import 'package:template_app_flutter/modules/auth/blocs/auth_blocs/auth_event.dart';
import 'package:template_app_flutter/modules/auth/pages/sign_in_page.dart';
import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:template_app_flutter/core/notifiers/theme_notifier.dart';
import 'package:template_app_flutter/core/language/language_sheet.dart';
import 'package:template_app_flutter/modules/auth/blocs/auth_blocs/auth_bloc.dart';

import '../blocs/profile_blocs/my_profile_bloc.dart';
import '../blocs/profile_blocs/my_profile_event.dart';
import '../blocs/profile_blocs/my_profile_state.dart';
import '../repositories/profile_repository.dart';
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
    final isLoggedIn = context.select<AuthBloc, bool>(
      (bloc) => bloc.isSignedIn,
    );

    if (!isLoggedIn) {
      return Scaffold(
        appBar: _buildAppBar(context),
        body: _buildContent(context, '', false),
      );
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider<MyProfileBloc>(
          create: (context) => MyProfileBloc(
            ProfileRepository(privateApi: PrivateApi(context: context)),
          )..add(const GetMyProfile()),
        ),
      ],
      child: BlocBuilder<MyProfileBloc, MyProfileState>(
        builder: (context, state) {
          final profileId = state.profileDetail.profileId;

          return Scaffold(
            appBar: _buildAppBar(context),
            body: _buildContent(context, profileId, true),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(title: Text('profile.title'.tr()), centerTitle: true);
  }

  Widget _buildContent(
    BuildContext context,
    String profileId,
    bool isLoggedIn,
  ) {
    final accountItems = _buildVisibleMenuItems(
      context,
      _accountMenuConfigs(profileId),
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
    if (!isLoggedIn) {
      return _buildGuestHeader(context);
    }

    return BlocBuilder<MyProfileBloc, MyProfileState>(
      builder: (context, state) {
        if (state is MyProfileLoading || state is MyProfileInitial) {
          return LoadingWidget();
        }

        if (state is MyProfileFailure) {
          return _buildUserHeaderFailure(context);
        }

        return _buildUserHeader(context, state as MyProfileSuccess);
      },
    );
  }

  Widget _buildUserHeaderFailure(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(ThemeConfig.spacingBase),
      child: Text(
        'error.request_failed'.tr(),
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  Widget _buildUserHeader(BuildContext context, MyProfileSuccess state) {
    final profile = state.profileDetail;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(ThemeConfig.spacingBase),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: ThemeConfig.colorPrimary,
              shape: BoxShape.circle,
            ),
            child: GestureDetector(
              onTap: () async {
                final avatarUrl = await Navigator.of(context).push<String>(
                  MaterialPageRoute(
                    builder: (context) => ProfileImagePage(
                      profileId: profile.profileId,
                      avatarUrl:
                          '${profile.avatarUrl}/${ImageSize.medium.text}',
                    ),
                  ),
                );

                if (avatarUrl != null && context.mounted) {
                  context.read<MyProfileBloc>().add(const GetMyProfile());
                }
              },
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Theme.of(context).primaryColor,
                backgroundImage: profile.avatarUrl.isEmpty
                    ? null
                    : CachedNetworkImageProvider(
                        '${profile.avatarUrl}/${ImageSize.extraSmall.text}',
                      ),
                child: profile.avatarUrl.isEmpty
                    ? Icon(
                        LineIcons.user,
                        color: Colors.white,
                        size: ThemeConfig.iconSizeLarge,
                      )
                    : null,
              ),
            ),
          ),
          const SizedBox(width: ThemeConfig.spacingBase),
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () async {
                final shouldReload = await Navigator.push<bool>(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AccountPage(profileId: profile.profileId),
                  ),
                );

                if (shouldReload == true && context.mounted) {
                  context.read<MyProfileBloc>().add(const GetMyProfile());
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profile.displayName,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: ThemeConfig.spacingXXS),
                  Text(
                    _formatJID(profile.jid),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: ThemeConfig.spacingMD),
                  Text(
                    profile.bio.isEmpty ? 'profile.no_bio'.tr() : profile.bio,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
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

  String _formatJID(String jid) {
    // Format as XXX-XXXX-XXXX
    if (jid.length >= 11) {
      return 'JID: ${jid.substring(0, 3)}-${jid.substring(3, 7)}-${jid.substring(7, 11)}';
    }
    return jid;
  }

  List<_MenuConfig> _accountMenuConfigs(String profileId) {
    if (profileId.isEmpty) {
      return [];
    }

    return [
      _MenuConfig(
        visibility: _MenuVisibility.authOnly,
        builder: (context) => MenuItem(
          icon: LineIcons.user,
          title: 'account.my_account'.tr(),
          onTap: () async {
            final shouldReload = await Navigator.push<bool>(
              context,
              MaterialPageRoute(
                builder: (context) => AccountPage(profileId: profileId),
              ),
            );

            if (shouldReload == true && context.mounted) {
              context.read<MyProfileBloc>().add(const GetMyProfile());
            }
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
            context.read<AuthBloc>().add(const SignOutRequested());
            nextScreenCloseOthers(context, AppPage());
          },
          child: Text('common.confirm'.tr()),
        ),
      ],
    );
  }
}
