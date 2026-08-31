import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:template_app_flutter/core/layouts/app_bar_widget.dart';
import 'package:template_app_flutter/core/utils/next_screen_util.dart';
import 'package:line_icons/line_icons.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../widgets/menu_item.dart';
import '../widgets/menu_item_value.dart';
import 'about_page.dart';
import 'app_version_page.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'info.title'.tr()),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return ListView(
      children: [
        FutureBuilder<String>(
          future: _getVersion(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('info.app_version.error'.tr()));
            } else {
              return MenuItemValue(
                icon: LineIcons.infoCircle,
                title: 'info.app_version.title'.tr(),
                value: snapshot.data ?? 'error.unexpected'.tr(),
                onTap: () {
                  nextScreen(context, const AppVersionPage());
                },
              );
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: ThemeConfig.spacingBase,
          ),
          child: Divider(height: ThemeConfig.spacingXS),
        ),

        MenuItem(
          icon: LineIcons.infoCircle,
          title: 'info.about.title'.tr(),
          onTap: () {
            nextScreen(context, const AboutPage());
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: ThemeConfig.spacingBase,
          ),
          child: Divider(height: ThemeConfig.spacingXS),
        ),
      ],
    );
  }

  Future<String> _getVersion() async {
    final info = await PackageInfo.fromPlatform();
    return '${info.version} (${info.buildNumber})';
  }
}
