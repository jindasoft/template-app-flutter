import 'package:template_app_flutter/configs/theme_config.dart';
import 'package:template_app_flutter/core/pages/center_page.dart';
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
  final _centerIndex = 1;
  final PageController _pageController = PageController();

  void onTabTapped(int index) {
    if (index == _centerIndex) {
      showModalBottomSheet(
        context: context,
        useSafeArea: true,
        isScrollControlled: true,
        enableDrag: true,
        useRootNavigator: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(ThemeConfig.spacingBase),
          ),
        ),
        builder: (context) =>
            FractionallySizedBox(heightFactor: 0.4, child: CenterPage()),
      );

      return;
    }

    int pageIndex = index > _centerIndex ? index - 1 : index;
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
          iconSize: ThemeConfig.iconSizeLarge,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: ThemeConfig.fontSize12,
          unselectedFontSize: ThemeConfig.fontSize12,
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
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[HomePage(), ProfilePage()],
        ),
      ),
    );
  }
}
