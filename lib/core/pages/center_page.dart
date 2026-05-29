import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class CenterPage extends StatelessWidget {
  const CenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildContent(context);
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(ThemeConfig.spacingBase),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(ThemeConfig.spacingBase),
            child: GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: ThemeConfig.spacingMedium,
              crossAxisSpacing: ThemeConfig.spacingMedium,
              children: [
                _buildGridButton(
                  context,
                  LineIcons.clock,
                  "navigation.center".tr(),
                  onTap: () async {
                    // final result = await Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => const Page(),
                    //   ),
                    // );

                    // if (context.mounted && result == true) {
                    //   Navigator.pop(
                    //     context,
                    //     true,
                    //   ); // Close the bottom sheet and pass success
                    // }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridButton(
    BuildContext context,
    IconData icon,
    String label, {
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: ThemeConfig.iconSizeExtraLarge),
          SizedBox(height: ThemeConfig.spacingExtraSmall),
          Text(label, style: Theme.of(context).textTheme.labelSmall),
        ],
      ),
    );
  }
}
