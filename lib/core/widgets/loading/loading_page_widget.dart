import 'package:flutter/material.dart';

class LoadingPageWidget extends StatelessWidget {
  const LoadingPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
