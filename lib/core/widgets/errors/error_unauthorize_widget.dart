import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class ErrorUnauthorizeWidget extends StatelessWidget {
  const ErrorUnauthorizeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('error.unauthorize.message'.tr()));
  }
}
