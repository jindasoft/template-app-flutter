import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:template_app_flutter/core/language/widgets/language_options_list.dart';

/// Shows a bottom sheet (80% of screen height) that lets the user pick the
/// app language. Selecting an option persists the locale via
/// [EasyLocalizationController] and closes the sheet.
Future<void> showLanguageSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (sheetContext) => const _LanguageSheet(),
  );
}

class _LanguageSheet extends StatelessWidget {
  const _LanguageSheet();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: ThemeConfig.spacingBase,
            ),
            child: Text(
              'language.selection'.tr(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const Expanded(child: LanguageOptionsList()),
        ],
      ),
    );
  }
}
