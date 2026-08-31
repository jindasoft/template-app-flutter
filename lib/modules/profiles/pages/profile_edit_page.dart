import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:template_app_flutter/core/layouts/app_bar_widget.dart';
import 'package:template_app_flutter/core/services/private_api.dart';
import 'package:template_app_flutter/core/utils/snackbar_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:template_app_flutter/core/widgets/errors/error_unauthorize_widget.dart';
import 'package:template_app_flutter/core/widgets/errors/error_request_widget.dart';
import 'package:template_app_flutter/core/widgets/fields/label_field_widget.dart';
import 'package:template_app_flutter/core/widgets/fields/text_field_widget.dart';
import 'package:template_app_flutter/core/widgets/loading/loading_page_widget.dart';
import 'package:template_app_flutter/modules/auth/blocs/auth_blocs/auth_bloc.dart';

import '../blocs/profile_blocs/profile_detail_bloc.dart';
import '../blocs/profile_blocs/profile_detail_event.dart';
import '../blocs/profile_blocs/profile_detail_state.dart';
import '../blocs/profile_blocs/profile_edit_bloc.dart';
import '../blocs/profile_blocs/profile_edit_event.dart';
import '../blocs/profile_blocs/profile_edit_state.dart';
import '../models/profile_edit.dart';
import '../repositories/profile_repository.dart';

class ProfileEditPage extends StatefulWidget {
  final String profileId;

  const ProfileEditPage({super.key, required this.profileId});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  late final TextEditingController _displayNameController;
  late final TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    _displayNameController = TextEditingController();
    _bioController = TextEditingController();
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.select<AuthBloc, bool>(
      (bloc) => bloc.isSignedIn,
    );

    if (!isLoggedIn) {
      return const ErrorUnauthorizeWidget();
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileDetailBloc>(
          create: (context) => ProfileDetailBloc(
            ProfileRepository(privateApi: PrivateApi(context: context)),
          )..add(GetProfileDetail(widget.profileId)),
        ),
        BlocProvider<ProfileEditBloc>(
          create: (context) => ProfileEditBloc(
            ProfileRepository(privateApi: PrivateApi(context: context)),
          ),
        ),
      ],
      child: BlocListener<ProfileEditBloc, ProfileEditState>(
        listener: (context, state) {
          if (state is ProfileEditSuccess) {
            Navigator.of(context).pop(state.profileDetail);
          } else if (state is ProfileEditFailure) {
            SnackBarUtils.showError(context, state.error.tr());
          }
        },
        child: BlocConsumer<ProfileDetailBloc, ProfileDetailState>(
          listener: (context, state) {
            if (state is ProfileDetailSuccess) {
              _displayNameController.text = state.profileDetail.displayName;
              _bioController.text = state.profileDetail.bio;
            }
          },
          builder: (context, state) {
            final isLoading = state is ProfileDetailLoading;
            final hasProfile = state is ProfileDetailSuccess;

            return Scaffold(
              appBar: AppBarWidget(title: 'profile.profile_edit.title'.tr()),
              body: hasProfile
                  ? _buildContent(context, state)
                  : isLoading
                  ? const LoadingPageWidget()
                  : const ErrorRequestWidget(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, ProfileDetailState state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(ThemeConfig.spacingBase),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Display Name Field
          LabelFieldWidget(text: 'profile.profile_edit.display_name'.tr()),
          const SizedBox(height: ThemeConfig.spacingSM),
          TextFieldWidget(
            controller: _displayNameController,
            hint: 'profile.profile_edit.display_name_hint'.tr(),
            icon: Icons.person,
          ),
          const SizedBox(height: ThemeConfig.spacingLG),

          // Bio Field
          LabelFieldWidget(text: 'profile.profile_edit.bio'.tr()),
          const SizedBox(height: ThemeConfig.spacingSM),
          TextFieldWidget(
            controller: _bioController,
            hint: 'profile.profile_edit.bio_hint'.tr(),
            icon: Icons.info,
            maxLines: 3,
          ),
          const SizedBox(height: ThemeConfig.spacingLG),

          // Action Buttons
          _actionButton(context, state),
        ],
      ),
    );
  }

  Widget _actionButton(BuildContext context, ProfileDetailState state) {
    return BlocBuilder<ProfileEditBloc, ProfileEditState>(
      builder: (context, editState) {
        final isSubmitting = editState is ProfileEditLoading;
        final isButtonDisabled =
            isSubmitting || state.profileDetail.profileId.isEmpty;

        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Cancel button
            OutlinedButton(
              onPressed: isButtonDisabled
                  ? null
                  : () => Navigator.of(context).pop(),
              child: Text('common.cancel'.tr()),
            ),

            // Submit button
            const SizedBox(width: ThemeConfig.spacingMD),
            ElevatedButton(
              onPressed: isButtonDisabled
                  ? null
                  : () => _handleSubmit(context, state),
              child: isSubmitting
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text('common.save'.tr()),
            ),
          ],
        );
      },
    );
  }

  void _handleSubmit(BuildContext context, ProfileDetailState state) {
    final profileEdit = ProfileEdit(
      displayName: _displayNameController.text.trim(),
      bio: _bioController.text.trim(),
    );

    context.read<ProfileEditBloc>().add(
      UpdateProfile(widget.profileId, profileEdit),
    );
  }
}
