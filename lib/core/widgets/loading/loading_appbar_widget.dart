import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LoadingAppbarWidget extends StatelessWidget {
  const LoadingAppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('loader.loading'.tr());
  }
}
