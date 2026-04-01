import 'package:template_app_flutter/app/app_page.dart';
import 'package:template_app_flutter/core/utils/next_screen_util.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// import 'intro_page.dart';

class DonePage extends StatefulWidget {
  const DonePage({super.key});

  @override
  State<DonePage> createState() => _DonePageState();
}

class _DonePageState extends State<DonePage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 2000)).then(
      (value) => {
        if (mounted) {nextScreenCloseOthers(context, AppPage())},
        // if (mounted) {nextScreenCloseOthers(context, IntroPage())},
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 160,
          width: 160,
          child: LottieBuilder.asset(
            'assets/lottiefiles/done.json',
            repeat: false,
          ),
        ),
      ),
    );
  }
}
