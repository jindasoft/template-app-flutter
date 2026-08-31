import 'package:template_app_flutter/configs/env_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:template_app_flutter/core/constants/http_header.dart';
import 'http_logger.dart';

import 'public_interceptor.dart';

class PublicApi {
  late final Dio _dio;

  PublicApi({required BuildContext context}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: EnvConfig.apiUrl!,
        connectTimeout: Duration(seconds: 5),
        receiveTimeout: Duration(seconds: 5),
        headers: {HttpHeader.contentType: 'application/json'},
      ),
    );

    // Interceptors
    _dio.interceptors.add(PublicInterceptor());
    _dio.options.extra['context'] = context;
    HttpLogger.attach(_dio);
  }

  Dio get dio => _dio;
}
