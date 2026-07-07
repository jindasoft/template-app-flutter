import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:template_app_flutter/core/layouts/app_bar_widget.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersionPage extends StatelessWidget {
  const AppVersionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'info.app_version.title'.tr()),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('info.app_version.error'.tr());
        } else {
          final packageInfo = snapshot.data!;

          return Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: ThemeConfig.spacingBase,
                ),
                title: Text('info.app_version.version'.tr()),
                trailing: Text(packageInfo.version),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: ThemeConfig.spacingBase,
                ),
                child: Divider(height: ThemeConfig.spacingXS),
              ),

              ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: ThemeConfig.spacingBase,
                ),
                title: Text('info.app_version.build_number'.tr()),
                trailing: Text(packageInfo.buildNumber),
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
      },
    );
  }
}
