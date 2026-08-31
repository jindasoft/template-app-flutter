import 'package:flutter/material.dart';

class ErrorGeneralWidget extends StatelessWidget {
  final String message;

  const ErrorGeneralWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: Theme.of(context).colorScheme.error,
        ),
      ),
    );
  }
}
