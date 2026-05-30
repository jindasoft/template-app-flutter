import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCacheImageWidget extends StatelessWidget {
  final String? imageUrl;
  const CustomCacheImageWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final placeholderColor = Theme.of(context).brightness == Brightness.dark
        ? ThemeConfig.colorBgDarkSecondary
        : ThemeConfig.colorBgLightSecondary;
    return CachedNetworkImage(
      imageUrl: imageUrl!,
      fit: BoxFit.cover,
      height: MediaQuery.of(context).size.height,
      placeholder: (context, url) => Container(color: placeholderColor),
      errorWidget: (context, url, error) =>
          Container(color: placeholderColor, child: Icon(Icons.error)),
    );
  }
}
