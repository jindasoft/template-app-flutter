import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:template_app_flutter/core/utils/responsive_util.dart';
import 'package:flutter/material.dart';

class GeneralErrorWidget extends StatelessWidget {
  final String message;

  const GeneralErrorWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: TextStyle(
          color: Theme.of(context).colorScheme.error,
          fontSize: responsiveSize(context, ThemeConfig.fontSizeBase),
        ),
      ),
    );
  }
}
