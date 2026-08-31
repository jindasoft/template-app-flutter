import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:template_app_flutter/core/utils/snackbar_util.dart';
import 'package:template_app_flutter/core/widgets/pickers/image_picker_sheet.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';

class ImagePickerFieldWidget extends StatefulWidget {
  final String hint;
  final Function(File?)? onImagePicked;
  final File? initialImage;
  final bool hasError;

  const ImagePickerFieldWidget({
    super.key,
    required this.hint,
    this.onImagePicked,
    this.initialImage,
    this.hasError = false,
  });

  @override
  State<ImagePickerFieldWidget> createState() => _ImagePickerFieldWidgetState();
}

class _ImagePickerFieldWidgetState extends State<ImagePickerFieldWidget> {
  late File? _selectedImage;
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _selectedImage = widget.initialImage;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showImagePickerDialog,
      child: Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border.all(
            color: widget.hasError
                ? Theme.of(context).colorScheme.error
                : Theme.of(context).dividerColor,
          ),
          borderRadius: BorderRadius.circular(ThemeConfig.spacingMD),
        ),
        child: _selectedImage != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(ThemeConfig.spacingMD - 2),
                child: Image.file(_selectedImage!, fit: BoxFit.cover),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    LineIcons.image,
                    size: ThemeConfig.iconSizeLarge,
                    color: ThemeConfig.colorGreyMedium,
                  ),
                  const SizedBox(height: ThemeConfig.spacingMD),
                  Text(
                    widget.hint,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: ThemeConfig.colorGreyMedium),
                  ),
                ],
              ),
      ),
    );
  }

  void _showImagePickerDialog() {
    ImagePickerSheet.show(
      context,
      onCameraTap: () => _pickImage(ImageSource.camera),
      onGalleryTap: () => _pickImage(ImageSource.gallery),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(source: source);

      if (pickedFile != null) {
        if (mounted) {
          setState(() {
            _selectedImage = File(pickedFile.path);
          });
          widget.onImagePicked?.call(_selectedImage);
        }
      }
    } catch (e) {
      if (mounted) {
        SnackBarUtils.showError(context, 'image_picker.image_pick_error'.tr());
      }
    }
  }
}
