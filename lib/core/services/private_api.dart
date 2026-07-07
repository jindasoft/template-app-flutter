import 'package:template_app_flutter/configs/env_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'http_logger.dart';

import 'private_interceptor.dart';

class PrivateApi {
  late final Dio _dio;

  PrivateApi({required BuildContext context}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: EnvConfig.apiUrl!,
        connectTimeout: Duration(seconds: 5),
        receiveTimeout: Duration(seconds: 5),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    // Interceptors
    final privateInterceptor = PrivateInterceptor();
    privateInterceptor.setDio(_dio);
    _dio.interceptors.add(privateInterceptor);
    _dio.options.extra['context'] = context;
    HttpLogger.attach(_dio);
  }

  Dio get dio => _dio;
}
