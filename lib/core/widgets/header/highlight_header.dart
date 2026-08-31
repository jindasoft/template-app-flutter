import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class HighlightHeader extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const HighlightHeader({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: ThemeConfig.spacingBase,
          vertical: ThemeConfig.spacingXXS,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: <Widget>[
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            SizedBox(width: ThemeConfig.spacingSM),
            Transform.translate(
              offset: Offset(0, 0),
              child: Icon(
                LineIcons.angleDoubleRight,
                size: ThemeConfig.iconSizeMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
