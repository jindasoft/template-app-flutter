import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final double height;
  final double width;

  const LoadingWidget({super.key, this.height = 20.0, this.width = 20.0});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: const CircularProgressIndicator(),
    );
  }
}
