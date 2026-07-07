import 'package:flutter/material.dart';
import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:template_app_flutter/core/layouts/app_bar_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:template_app_flutter/core/widgets/fields/label_field_widget.dart';
import 'package:template_app_flutter/core/widgets/fields/text_field_widget.dart';

class ProfileEditPage extends StatelessWidget {
  const ProfileEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'profile.profile_edit.title'.tr()),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(ThemeConfig.spacingBase),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Display Name Field
          LabelFieldWidget(text: 'profile.profile_edit.display_name'.tr()),
          const SizedBox(height: ThemeConfig.spacingSM),
          TextFieldWidget(
            controller: TextEditingController(),
            hint: 'profile.profile_edit.display_name_hint'.tr(),
            icon: Icons.person,
          ),
          const SizedBox(height: ThemeConfig.spacingLG),

          // Bio Field
          LabelFieldWidget(text: 'profile.profile_edit.bio'.tr()),
          const SizedBox(height: ThemeConfig.spacingSM),
          TextFieldWidget(
            controller: TextEditingController(),
            hint: 'profile.profile_edit.bio_hint'.tr(),
            icon: Icons.info,
            maxLines: 3,
          ),
          const SizedBox(height: ThemeConfig.spacingLG),

          // Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Cancel button
              OutlinedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('common.cancel'.tr()),
              ),

              // Submit button
              const SizedBox(width: ThemeConfig.spacingMD),
              ElevatedButton(
                onPressed: () => _handleSubmit(context),
                child: Text('common.save'.tr()),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _handleSubmit(BuildContext context) {
    // Handle the submit action here
  }
}
