import 'package:template_app_flutter/configs/env_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'public_interceptor.dart';

class PublicAuth {
  late final Dio _dio;

  PublicAuth({required BuildContext context}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: EnvConfig.authUrl!,
        connectTimeout: Duration(seconds: 5),
        receiveTimeout: Duration(seconds: 5),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    // Interceptors
    _dio.interceptors.add(PublicInterceptor());
    _dio.options.extra['context'] = context;
  }

  Dio get dio => _dio;
}
