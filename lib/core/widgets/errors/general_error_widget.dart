import 'package:flutter/material.dart';

class GeneralErrorWidget extends StatelessWidget {
  final String message;

  const GeneralErrorWidget({super.key, required this.message});

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
