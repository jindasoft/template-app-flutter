import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

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
                color: Colors.black26,
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
                color: Colors.red.withValues(alpha: 0.8),
                borderRadius: borderRadius ?? BorderRadius.zero,
              ),
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'shared.loading_overlay_widget.error_message'.tr(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (onRetry != null) ...[
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: onRetry,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      ),
                      child: Text(
                        'shared.loading_overlay_widget.retry'.tr(),
                        style: TextStyle(
                          color: Colors.red,
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
