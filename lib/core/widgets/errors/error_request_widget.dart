import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ErrorRequestWidget extends StatelessWidget {
  const ErrorRequestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('error.request_failed'.tr()));
  }
}
