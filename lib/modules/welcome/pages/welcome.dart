import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:template_app_flutter/configs/language_config.dart';
import 'package:template_app_flutter/configs/theme_config.dart';

class Welcome extends StatefulWidget {
  final VoidCallback? onContinue;

  const Welcome({super.key, this.onContinue});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  Locale? _selectedLocale;
  bool _didInitLocale = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_didInitLocale) {
      return;
    }
    _didInitLocale = true;
    _initLocaleFromDevice();
  }

  Future<void> _initLocaleFromDevice() async {
    final deviceLocale = WidgetsBinding.instance.platformDispatcher.locale;
    final locales = languages.map((e) => e.locale).toList(growable: false);

    Locale? selected = locales
        .where(
          (locale) =>
              locale.languageCode == deviceLocale.languageCode &&
              locale.countryCode == deviceLocale.countryCode,
        )
        .cast<Locale?>()
        .firstWhere((locale) => locale != null, orElse: () => null);

    selected ??= locales
        .where((locale) => locale.languageCode == deviceLocale.languageCode)
        .cast<Locale?>()
        .firstWhere((locale) => locale != null, orElse: () => null);

    selected ??= locales
        .where((locale) => locale.languageCode == context.locale.languageCode)
        .cast<Locale?>()
        .firstWhere((locale) => locale != null, orElse: () => null);

    selected ??= locales
        .where((locale) => locale.languageCode == 'en')
        .cast<Locale?>()
        .firstWhere((locale) => locale != null, orElse: () => null);

    selected ??= locales.first;

    if (!mounted) {
      return;
    }

    setState(() {
      _selectedLocale = selected;
    });

    if (context.locale != selected) {
      await context.setLocale(selected);
    }
  }

  Future<void> _selectLocale(Locale locale) async {
    setState(() {
      _selectedLocale = locale;
    });
    await context.setLocale(locale);
  }

  void _continue() {
    final onContinue = widget.onContinue;
    if (onContinue != null) {
      onContinue();
      return;
    }

    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasSelectedLanguage = _selectedLocale != null;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(ThemeConfig.spacingLG),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: ThemeConfig.spacingXL),
              Text(
                'app.title'.tr(),
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(height: ThemeConfig.spacingXS),

              Text(
                'app.subtitle'.tr(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: ThemeConfig.spacingXL),

              Text(
                'language.selection'.tr(),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: ThemeConfig.spacingSM),
              Expanded(
                child: ListView.separated(
                  itemCount: languages.length,
                  separatorBuilder: (_, _) =>
                      const SizedBox(height: ThemeConfig.spacingSM),
                  itemBuilder: (context, index) {
                    final option = languages[index];
                    final isSelected =
                        _selectedLocale?.languageCode ==
                        option.locale.languageCode;

                    return ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          ThemeConfig.spacingMD,
                        ),
                        side: BorderSide(
                          color: isSelected
                              ? ThemeConfig.colorPrimary
                              : ThemeConfig.colorGreyMedium,
                        ),
                      ),
                      leading: Icon(
                        isSelected ? LineIcons.checkCircle : LineIcons.circle,
                        color: isSelected ? ThemeConfig.colorPrimary : null,
                      ),
                      title: Text(option.label),
                      trailing: Text(option.trailingLabel),
                      onTap: () => _selectLocale(option.locale),
                    );
                  },
                ),
              ),
              const SizedBox(height: ThemeConfig.spacingBase),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: hasSelectedLanguage ? _continue : null,
                  child: Text('common.next'.tr()),
                ),
              ),
              const SizedBox(height: ThemeConfig.spacingBase),
            ],
          ),
        ),
      ),
    );
  }
}
