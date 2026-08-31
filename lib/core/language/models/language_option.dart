import 'package:flutter/material.dart';

class LanguageOption {
  final String label;
  final String trailingLabel;
  final Locale locale;

  const LanguageOption({
    required this.label,
    required this.trailingLabel,
    required this.locale,
  });
}
