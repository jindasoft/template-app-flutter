import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:line_icons/line_icons.dart';

class ImagePickerSheet extends StatelessWidget {
  final VoidCallback onCameraTap;
  final VoidCallback onGalleryTap;
  final String? title;

  const ImagePickerSheet({
    super.key,
    required this.onCameraTap,
    required this.onGalleryTap,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: ThemeConfig.spacingBase,
            ),
            child: Text(
              title ?? 'image_picker.select_image'.tr(),
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          _MenuItem(
            icon: LineIcons.camera,
            title: 'image_picker.camera'.tr(),
            onTap: () => {Navigator.pop(context), onCameraTap()},
          ),
          _MenuItem(
            icon: LineIcons.image,
            title: 'image_picker.gallery'.tr(),
            onTap: () => {Navigator.pop(context), onGalleryTap()},
          ),
          const SizedBox(height: ThemeConfig.spacingXL),
        ],
      ),
    );
  }

  static void show(
    BuildContext context, {
    required VoidCallback onCameraTap,
    required VoidCallback onGalleryTap,
    String? title,
  }) {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      enableDrag: true,
      useRootNavigator: false,
      builder: (context) => ImagePickerSheet(
        onCameraTap: onCameraTap,
        onGalleryTap: onGalleryTap,
        title: title,
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: ThemeConfig.spacingBase,
      ),
      leading: Icon(icon),
      title: Text(title, style: Theme.of(context).textTheme.bodyMedium),
      onTap: onTap,
    );
  }
}
