import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class LoadingCard extends StatelessWidget {
  final double height;

  const LoadingCard({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    final skeletonColor = Theme.of(context).brightness == Brightness.dark
        ? ThemeConfig.colorBgDarkSecondary
        : ThemeConfig.colorBgLightSecondary;
    return SizedBox(
      height: height,
      child: SkeletonAnimation(
        child: Container(
          decoration: BoxDecoration(
            color: skeletonColor,
            borderRadius: BorderRadius.circular(ThemeConfig.spacingSmall),
          ),
          height: height,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}
