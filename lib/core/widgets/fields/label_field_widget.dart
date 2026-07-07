import 'package:flutter/material.dart';

class LabelFieldWidget extends StatelessWidget {
  final String text;

  const LabelFieldWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.bodyMedium);
  }
}
