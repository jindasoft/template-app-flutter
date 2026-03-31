import 'package:flutter/material.dart';

double responsiveSize(BuildContext context, double base) {
  final width = MediaQuery.of(context).size.width;
  if (width < 600) return base;
  if (width < 900) return base + 4;
  return base + 8;
}

bool isMobile(BuildContext context) {
  final size = MediaQuery.of(context).size;
  return size.shortestSide < 600;
}

bool isTablet(BuildContext context) {
  final size = MediaQuery.of(context).size;
  return size.shortestSide >= 600;
}
