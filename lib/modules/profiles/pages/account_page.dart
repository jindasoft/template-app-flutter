import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template_app_flutter/app/app_page.dart';
import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:template_app_flutter/core/layouts/app_bar_widget.dart';
import 'package:template_app_flutter/core/utils/next_screen_util.dart';
import 'package:template_app_flutter/core/utils/snackbar_util.dart';
import 'package:template_app_flutter/core/widgets/errors/error_unauthorize_widget.dart';
import 'package:template_app_flutter/modules/auth/blocs/auth_blocs/auth_bloc.dart';
import 'package:template_app_flutter/modules/auth/blocs/auth_blocs/auth_event.dart';
import 'package:template_app_flutter/modules/auth/blocs/auth_blocs/auth_state.dart';
import 'package:line_icons/line_icons.dart';

import '../widgets/menu_item.dart';
import 'profile_edit_page.dart';

class AccountPage extends StatelessWidget {
  final String profileId;

  const AccountPage({super.key, required this.profileId});

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.select<AuthBloc, bool>(
      (bloc) => bloc.isSignedIn,
    );

    if (!isLoggedIn) {
      return const ErrorUnauthorizeWidget();
    }

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
          onTap: () async {
            final updatedProfile = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileEditPage(profileId: profileId),
              ),
            );

            if (updatedProfile != null && context.mounted) {
              Navigator.of(context).pop(true);
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
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is DeleteAccountSuccess) {
          _showSuccessDialog(context);
        } else if (state is DeleteAccountFailure) {
          SnackBarUtils.showError(context, state.error.tr());
        }
      },
      builder: (context, state) {
        final isLoading = state is DeleteAccountLoading;

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
                    onPressed: isLoading
                        ? null
                        : () {
                            context.read<AuthBloc>().add(
                              const DeleteAccountRequested(),
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      disabledBackgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(
                        vertical: ThemeConfig.spacingMD,
                      ),
                    ),
                    child: isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text('account.delete_account_confirm'.tr()),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showSuccessDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: Text('account.delete_account_success_title'.tr()),
        content: Text('account.delete_account_success'.tr()),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              Navigator.of(context).pop();
              nextScreenCloseOthers(context, AppPage());
            },
            child: Text('common.ok'.tr()),
          ),
        ],
      ),
    );
  }
}
