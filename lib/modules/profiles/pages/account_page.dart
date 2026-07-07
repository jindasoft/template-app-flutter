import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:template_app_flutter/core/layouts/app_bar_widget.dart';
import 'package:template_app_flutter/core/utils/next_screen_util.dart';
import 'package:line_icons/line_icons.dart';

import '../widgets/menu_item.dart';
import 'profile_edit_page.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'account.title'.tr()),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return ListView(
      children: [
        MenuItem(
          icon: LineIcons.userEdit,
          title: 'profile.profile_edit.title'.tr(),
          onTap: () {
            nextScreen(context, const ProfileEditPage());
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: ThemeConfig.spacingBase,
          ),
          child: Divider(height: ThemeConfig.spacingXS),
        ),

        MenuItem(
          icon: LineIcons.trash,
          title: 'account.delete_account'.tr(),
          onTap: () {
            _showDeleteAccountSheet(context);
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

  Future<void> _showDeleteAccountSheet(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) => const _DeleteAccountSheet(),
    );
  }
}

class _DeleteAccountSheet extends StatelessWidget {
  const _DeleteAccountSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.7,
      padding: const EdgeInsets.all(ThemeConfig.spacingBase),
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  'account.delete_account_title'.tr(),
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: ThemeConfig.spacingBase),
                Text(
                  'account.delete_account_description'.tr(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: ThemeConfig.spacingMD,
              bottom: ThemeConfig.spacingBase,
            ),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Theme.of(context).dividerColor),
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Implement delete account functionality
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(
                    vertical: ThemeConfig.spacingMD,
                  ),
                ),
                child: Text('account.delete_account_confirm'.tr()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
