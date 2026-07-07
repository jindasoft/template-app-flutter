import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:template_app_flutter/configs/language_config.dart';
import 'package:line_icons/line_icons.dart';

class LanguageOptionsList extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final bool popOnSelect;

  const LanguageOptionsList({super.key, this.padding, this.popOnSelect = true});

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale;
    return ListView.builder(
      padding: padding,
      itemCount: languages.length,
      itemBuilder: (context, index) {
        final option = languages[index];
        final selected =
            currentLocale.languageCode == option.locale.languageCode;
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: ThemeConfig.spacingBase,
          ),
          leading: Icon(
            selected ? LineIcons.checkCircle : LineIcons.circle,
            color: selected ? ThemeConfig.colorPrimary : null,
          ),
          title: Text(
            option.label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          trailing: Text(
            option.trailingLabel,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          onTap: () => _select(context, option.locale),
        );
      },
    );
  }

  Future<void> _select(BuildContext context, Locale locale) async {
    await context.setLocale(locale);
    if (popOnSelect && context.mounted) {
      Navigator.of(context).pop();
    }
  }
}
