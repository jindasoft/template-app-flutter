import 'package:flutter/material.dart';

class AppConfig {
  static final String appName = 'template_app_flutter';
  static const String userSource = 'app';

  // Language Setup
  static const Locale defaultLanguage = Locale('en', 'US');
  final List<String> languages = ['English', 'ไทย'];

  // Image upload
  final int imageSizeOriginal = 2048;
  final int imageQuality = 85;
}
