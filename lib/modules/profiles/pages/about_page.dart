import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:template_app_flutter/configs/app_config.dart';
import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:template_app_flutter/core/layouts/app_bar_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  Future<void> _openWebsite(BuildContext context) async {
    final rawUrl = AppConfig.website.trim();
    final normalizedUrl =
        rawUrl.startsWith('http://') || rawUrl.startsWith('https://')
        ? rawUrl
        : 'https://$rawUrl';

    final uri = Uri.tryParse(normalizedUrl);
    if (uri == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Invalid website URL')));
      return;
    }

    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched && context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Unable to open website')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'info.about.title'.tr()),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final contentMaxWidth = width >= 700 ? 560.0 : width * 0.92;
        final horizontalPadding = width < 360
            ? ThemeConfig.spacingBase
            : ThemeConfig.spacingLG;
        final topSpacing = width < 360
            ? ThemeConfig.spacingLG
            : ThemeConfig.spacingXXL;
        final sectionSpacing = width < 360
            ? ThemeConfig.spacingLG
            : ThemeConfig.spacingXL;
        final dividerWidth = (contentMaxWidth * 0.45).clamp(110.0, 180.0);

        return SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: contentMaxWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: topSpacing),
                    Text(
                      'app.title'.tr(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displayLarge,
                    ),
                    const SizedBox(height: ThemeConfig.spacingXS),

                    Text(
                      'app.subtitle'.tr(),
                      textAlign: TextAlign.center,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(height: 1.35),
                    ),
                    SizedBox(height: sectionSpacing),

                    Text(
                      'app.description'.tr(),
                      textAlign: TextAlign.center,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(height: 1.5),
                    ),
                    SizedBox(height: sectionSpacing),
                    Text(
                      'app.tagline'.tr(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: ThemeConfig.spacingMD),
                    Container(
                      height: 1,
                      width: dividerWidth,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    SizedBox(height: sectionSpacing),
                    Text(
                      AppConfig.appName,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: ThemeConfig.spacingSM),
                    Material(
                      type: MaterialType.transparency,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(
                          ThemeConfig.spacingSM,
                        ),
                        splashColor: Theme.of(
                          context,
                        ).primaryColor.withValues(alpha: 0.24),
                        highlightColor: Theme.of(
                          context,
                        ).primaryColor.withValues(alpha: 0.12),
                        onTap: () => _openWebsite(context),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: ThemeConfig.spacingSM,
                            vertical: ThemeConfig.spacingXS,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Flexible(
                                child: Text(
                                  AppConfig.website,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                              const SizedBox(width: ThemeConfig.spacingSM),
                              Icon(
                                Icons.open_in_new,
                                size: ThemeConfig.iconSizeMedium,
                                color: Theme.of(context).iconTheme.color,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: ThemeConfig.spacingXXL),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
