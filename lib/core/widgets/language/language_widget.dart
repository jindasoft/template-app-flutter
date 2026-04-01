import 'package:template_app_flutter/configs/app_config.dart';
import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:template_app_flutter/core/utils/responsive_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class LanguageWidget extends StatefulWidget {
  const LanguageWidget({super.key});

  @override
  State<LanguageWidget> createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends State<LanguageWidget> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('language.selection').tr(),
        centerTitle: false,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: AppConfig().languages.length,
        itemBuilder: (BuildContext context, int index) {
          return _itemList(AppConfig().languages[index], index);
        },
      ),
    );
  }

  Widget _itemList(String lang, int index) {
    return Column(
      children: [
        ListTile(
          leading: Icon(LineIcons.language),
          title: Text(
            lang,
            style: TextStyle(
              fontSize: responsiveSize(context, ThemeConfig.fontSizeBase),
            ),
          ),
          onTap: () async {
            if (lang == 'English') {
              context.setLocale(Locale('en', 'US'));
            } else if (lang == 'ไทย') {
              context.setLocale(Locale('th', 'TH'));
            }
            Navigator.pop(context);
          },
        ),
        Divider(height: 5),
      ],
    );
  }
}
