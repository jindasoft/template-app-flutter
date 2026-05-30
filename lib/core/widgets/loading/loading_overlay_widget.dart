import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:template_app_flutter/configs/theme_config.dart';

class LoadingOverlay extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final BorderRadius? borderRadius;
  final String? error;
  final VoidCallback? onRetry;

  const LoadingOverlay({
    super.key,
    required this.child,
    required this.isLoading,
    this.borderRadius,
    this.error,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).shadowColor.withValues(alpha: 0.26),
                borderRadius: borderRadius ?? BorderRadius.circular(8),
              ),
              child: const Center(child: CircularProgressIndicator()),
            ),
          ),
        if (error != null)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: ThemeConfig.colorError.withValues(alpha: 0.8),
                borderRadius: borderRadius ?? BorderRadius.zero,
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'shared.loading_overlay_widget.error_message'.tr(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (onRetry != null) ...[
                    SizedBox(height: ThemeConfig.spacingSmall),
                    ElevatedButton(
                      onPressed: onRetry,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.onPrimary,
                        padding: EdgeInsets.symmetric(
                          horizontal: ThemeConfig.spacingMedium,
                          vertical: ThemeConfig.spacingSmall,
                        ),
                      ),
                      child: Text(
                        'shared.loading_overlay_widget.retry'.tr(),
                        style: TextStyle(
                          color: ThemeConfig.colorError,
                          fontSize: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.fontSize,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
      ],
    );
  }
}
