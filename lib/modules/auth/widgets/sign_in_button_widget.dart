import 'package:flutter/material.dart';
import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:template_app_flutter/core/widgets/loading/loading_widget.dart';

class SignInButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;
  final Color backgroundColor;
  final Color textColor;
  final String label;
  final Widget icon;

  const SignInButtonWidget({
    super.key,
    required this.onPressed,
    required this.isLoading,
    required this.backgroundColor,
    required this.textColor,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 55,
      width: MediaQuery.of(context).size.width * 0.8,
      child: TextButton(
        onPressed: isLoading ? null : onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(backgroundColor),
          side: WidgetStatePropertyAll(
            BorderSide(
              color: isDarkMode
                  ? ThemeConfig.colorBorderDark
                  : ThemeConfig.colorBorderLight,
            ),
          ),
        ),
        child: isLoading
            ? LoadingWidget()
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 35,
                    child: Align(alignment: Alignment.center, child: icon),
                  ),

                  SizedBox(
                    width: 160,
                    child: Text(
                      label,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(color: textColor),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
