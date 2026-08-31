import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:template_app_flutter/configs/app_config.dart';
import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:template_app_flutter/core/layouts/app_bar_widget.dart';
import 'package:template_app_flutter/core/services/private_api.dart';
import 'package:template_app_flutter/core/utils/snackbar_util.dart';
import 'package:template_app_flutter/core/widgets/loading/loading_widget.dart';
import 'package:image_picker/image_picker.dart';

import '../blocs/profile_image_blocs/profile_image_bloc.dart';
import '../repositories/profile_image_repository.dart';
import 'profile_image_edit_page.dart';

class ProfileImagePage extends StatefulWidget {
  final String profileId;
  final String avatarUrl;

  const ProfileImagePage({
    super.key,
    required this.profileId,
    required this.avatarUrl,
  });

  @override
  State<ProfileImagePage> createState() => _ProfileImagePageState();
}

class _ProfileImagePageState extends State<ProfileImagePage> {
  final ImagePicker _imagePicker = ImagePicker();
  File? _previewImage;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileImageBloc(
        ProfileImageRepository(privateApi: PrivateApi(context: context)),
      ),
      child: Builder(
        builder: (providerContext) => Scaffold(
          appBar: AppBarWidget(title: 'profile.profile_image.title'.tr()),
          body: _buildContent(providerContext),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildAvatar(context),
          const SizedBox(height: ThemeConfig.spacingBase),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () {
                  _pickImage(context, ImageSource.gallery);
                },
                child: Text('profile.profile_image.upload_new_image'.tr()),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(BuildContext context) {
    final image = _previewImage;

    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: image != null
            ? Image.file(image, fit: BoxFit.cover)
            : widget.avatarUrl.isEmpty
            ? const SizedBox.shrink()
            : Image.network(
                widget.avatarUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }

                  return const Center(
                    child: LoadingWidget(height: 36, width: 36),
                  );
                },
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.person, color: Colors.white, size: 80),
              ),
      ),
    );
  }

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: source,
        imageQuality: AppConfig.profileImageQuality,
        maxWidth: AppConfig.profileImageDimension,
        maxHeight: AppConfig.profileImageDimension,
      );

      if (pickedFile != null) {
        if (!context.mounted) {
          return;
        }

        final selectedImage = File(pickedFile.path);
        final avatarUrl = await Navigator.of(context).push<String>(
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (_) => BlocProvider.value(
              value: context.read<ProfileImageBloc>(),
              child: ProfileImageEditPage(
                profileId: widget.profileId,
                initialImage: selectedImage,
              ),
            ),
          ),
        );

        if (!context.mounted) {
          return;
        }

        if (avatarUrl == null) {
          return;
        }

        Navigator.of(context).pop(avatarUrl);
      }
    } catch (e) {
      if (context.mounted) {
        SnackBarUtils.showError(context, 'image_picker.image_pick_error'.tr());
      }
    }
  }
}
