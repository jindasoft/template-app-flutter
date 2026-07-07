import 'package:flutter/material.dart';

class LoadingImageWidget extends StatelessWidget {
  const LoadingImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300],
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}
