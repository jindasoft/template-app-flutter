import 'package:template_app_flutter/configs/app_config.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:template_app_flutter/core/constants/http_header.dart';

class PublicInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final locale =
        EasyLocalization.of(options.extra['context'])?.locale ??
        AppConfig.defaultLanguage;

    final headers = {HttpHeader.acceptLanguage: locale.toLanguageTag()};
    options.headers.addAll(headers);

    handler.next(options);
  }
}
