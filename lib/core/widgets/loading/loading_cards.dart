import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class LoadingCard extends StatelessWidget {
  final double height;

  const LoadingCard({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: SkeletonAnimation(
        child: Container(
          decoration: BoxDecoration(
            color: ThemeConfig.colorGreyLight,
            borderRadius: BorderRadius.circular(3),
          ),
          height: height,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}
