import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:template_app_flutter/core/layouts/app_bar_widget.dart';
import 'package:template_app_flutter/core/utils/snackbar_util.dart';
import 'package:image_picker/image_picker.dart';

import 'profile_image_edit_page.dart';

class ProfileImagePage extends StatefulWidget {
  final String avatarUrl;

  const ProfileImagePage({super.key, required this.avatarUrl});

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
    return Scaffold(
      appBar: AppBarWidget(title: 'profile.profile_image.title'.tr()),
      body: _buildContent(context),
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
          CircleAvatar(
            radius: 150,
            backgroundImage: _previewImage != null
                ? FileImage(_previewImage!)
                : (widget.avatarUrl.isNotEmpty
                      ? NetworkImage(widget.avatarUrl)
                      : null),
          ),
          const SizedBox(height: ThemeConfig.spacingBase),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () {
                  _pickImage(ImageSource.gallery);
                },
                child: Text('profile.profile_image.upload_new_image'.tr()),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: source,
        imageQuality: 95,
        maxWidth: 2048,
        maxHeight: 2048,
      );

      if (pickedFile != null) {
        if (!mounted) {
          return;
        }

        final selectedImage = File(pickedFile.path);
        final croppedImage = await Navigator.of(context).push<File>(
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (_) => ProfileImageEditPage(initialImage: selectedImage),
          ),
        );

        if (!mounted || croppedImage == null) {
          return;
        }

        setState(() {
          _previewImage = croppedImage;
        });
      }
    } catch (e) {
      if (mounted) {
        SnackBarUtils.showError(context, 'image_picker.image_pick_error'.tr());
      }
    }
  }
}
