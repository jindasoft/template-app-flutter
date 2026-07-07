import 'package:flutter/material.dart';
import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:template_app_flutter/core/enums/screen_size.dart';

import '../models/content_image.dart';

class CardSliderWidget extends StatelessWidget {
  final ContentImage contentImage;
  final VoidCallback onTap;

  const CardSliderWidget({
    super.key,
    required this.contentImage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    late double width;
    if (screenWidth < ScreenSize.base.value) {
      width = 0.40;
    } else if (screenWidth < ScreenSize.extra.value) {
      width = 0.30;
    } else {
      width = 0.23;
    }
    final itemWidth = screenWidth * width;

    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(right: ThemeConfig.spacingBase),
        width: itemWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(ThemeConfig.spacingBase),
              child: Image.network(
                height: MediaQuery.of(context).size.height * 0.13,
                contentImage.imageCover,
                // "${EnvConfig.imgUrl}/${contentImage.imageCover}/${ImageSize.small.text}",
                fit: BoxFit.fill,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.broken_image),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: ThemeConfig.spacingSM,
              ),
              child: Text(
                contentImage.name,
                maxLines: 2,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
