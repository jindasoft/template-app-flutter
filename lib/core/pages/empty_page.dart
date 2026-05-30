import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  final IconData icon;
  final String message;
  final String description;

  const EmptyPage({
    super.key,
    required this.icon,
    required this.message,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 100),
          SizedBox(height: ThemeConfig.spacingMedium),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displaySmall,
          ),
          SizedBox(height: ThemeConfig.spacingExtraSmall),
          Text(
            description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
