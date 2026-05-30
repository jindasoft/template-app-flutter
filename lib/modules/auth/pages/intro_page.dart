import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:template_app_flutter/core/utils/next_screen_util.dart';
import 'package:template_app_flutter/app/app_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: h * 0.82,
            child: AnotherCarousel(
              dotVerticalPadding: h * 0.00,
              dotColor: ThemeConfig.colorGreyMedium,
              dotIncreasedColor: Theme.of(context).primaryColor,
              autoplay: false,
              dotBgColor: Colors.transparent,
              dotSize: 6,
              dotSpacing: 15,
              images: [
                // IntroView(
                //   title: 'intro.title1'.tr(),
                //   description: 'intro.description1'.tr(),
                //   image: AppConfig().introImage1,
                // ),
                // IntroView(
                //   title: 'intro.title2'.tr(),
                //   description: 'intro.description2'.tr(),
                //   image: AppConfig().introImage2,
                // ),
                // IntroView(
                //   title: 'intro.title3'.tr(),
                //   description: 'intro.description3'.tr(),
                //   image: AppConfig().introImage3,
                // ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Container(
            height: 50,
            width: w * 0.70,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(25),
            ),
            child: TextButton(
              style: ButtonStyle(
                shape: WidgetStateProperty.resolveWith(
                  (states) => RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              child: Text(
                'intro.get_started'.tr(),
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ).tr(),
              onPressed: () {
                nextScreenReplace(context, AppPage());
              },
            ),
          ),
          SizedBox(height: 0.15),
        ],
      ),
    );
  }
}

class IntroView extends StatelessWidget {
  final String title;
  final String description;
  final String image;
  const IntroView({
    super.key,
    required this.title,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 50),
          Container(
            alignment: Alignment.center,
            height: h * 0.38,
            child: Image(image: AssetImage(image), fit: BoxFit.contain),
          ),
          SizedBox(height: 25),

          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Text(
              title.tr(),
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.w900,
                color: Theme.of(context).brightness == Brightness.dark
                    ? ThemeConfig.colorTextDarkPrimary
                    : ThemeConfig.colorTextLightPrimary,
                letterSpacing: -0.7,
                wordSpacing: 1,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            height: 3,
            width: 150,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          SizedBox(height: 15),

          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Text(
              description.tr(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).brightness == Brightness.dark
                    ? ThemeConfig.colorTextDarkSecondary
                    : ThemeConfig.colorTextLightSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
