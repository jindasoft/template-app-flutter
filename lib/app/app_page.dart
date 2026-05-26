import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:template_app_flutter/core/pages/center_page.dart';
import 'package:template_app_flutter/core/utils/responsive_util.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';
import 'package:template_app_flutter/modules/home/pages/home_page.dart';
import 'package:template_app_flutter/modules/profiles/pages/profile_page.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() {
    return _AppPageState();
  }
}

class _AppPageState extends State<AppPage> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  void onTabTapped(int index) {
    if (index == 1) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (context) =>
            FractionallySizedBox(heightFactor: 0.4, child: CenterPage()),
      );

      return;
    }

    int pageIndex = index > 1 ? index - 1 : index;
    setState(() => _currentIndex = index);
    _pageController.animateToPage(
      pageIndex,
      curve: Curves.easeIn,
      duration: Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future _onWillPop() async {
    if (_currentIndex != 0) {
      setState(() => _currentIndex = 0);
      _pageController.animateToPage(
        0,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      await SystemChannels.platform.invokeMethod<void>(
        'SystemNavigator.pop',
        true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _onWillPop();
      },
      child: Scaffold(
        appBar: AppBar(elevation: 0, toolbarHeight: 0),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => onTabTapped(index),
          iconSize: responsiveSize(context, ThemeConfig.iconSizeLarge),
          type: BottomNavigationBarType.fixed,
          selectedFontSize: responsiveSize(
            context,
            ThemeConfig.fontSizeExtraSmall,
          ),
          unselectedFontSize: responsiveSize(
            context,
            ThemeConfig.fontSizeExtraSmall,
          ),
          selectedItemColor: Theme.of(context).colorScheme.primary,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          items: [
            BottomNavigationBarItem(
              icon: Icon(LineIcons.home),
              label: 'navigation.home'.tr(),
            ),

            BottomNavigationBarItem(
              icon: Icon(LineIcons.plus),
              label: 'navigation.center'.tr(),
            ),

            BottomNavigationBarItem(
              icon: Icon(LineIcons.user),
              label: 'navigation.profile'.tr(),
            ),
          ],
        ),
        body: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[HomePage(), ProfilePage()],
        ),
      ),
    );
  }
}
