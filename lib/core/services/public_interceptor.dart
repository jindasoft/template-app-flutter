import 'dart:ui';

import 'package:template_app_flutter/configs/app_config.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';

class PublicInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final Locale locale =
        EasyLocalization.of(options.extra['context'])?.locale ??
        AppConfig.defaultLanguage;

    options.headers.addAll({'Accept-Language': locale.toLanguageTag()});

    super.onRequest(options, handler);
  }
}
