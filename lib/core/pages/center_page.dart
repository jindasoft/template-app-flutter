import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:template_app_flutter/core/utils/responsive_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class CenterPage extends StatelessWidget {
  const CenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _widgetMore(context);
  }

  Widget _widgetMore(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark
            ? ThemeConfig.colorBgDarkPrimary
            : ThemeConfig.colorBgLightPrimary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
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
          Icon(
            icon,
            size: responsiveSize(context, ThemeConfig.iconSizeExtraLarge),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: responsiveSize(context, ThemeConfig.fontSizeExtraSmall),
            ),
          ),
        ],
      ),
    );
  }
}
