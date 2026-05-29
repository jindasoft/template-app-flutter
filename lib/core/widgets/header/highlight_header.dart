import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class HighlightHeader extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const HighlightHeader({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: ThemeConfig.spacingBase),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: <Widget>[
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(width: ThemeConfig.spacingSmall),
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
