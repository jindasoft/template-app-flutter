import 'package:template_app_flutter/configs/env_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'private_interceptor.dart';

class PrivateImage {
  late final Dio _dio;

  PrivateImage({required BuildContext context}) {
    _dio = Dio(
      BaseOptions(
        baseUrl: EnvConfig.imgUrl!,
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 50),
        headers: {'Content-Type': 'multipart/form-data'},
      ),
    );

    // Add interceptor to handle authorization headers
    final privateInterceptor = PrivateInterceptor();
    privateInterceptor.setDio(_dio);
    _dio.interceptors.add(privateInterceptor);
    // _dio.interceptors.add(PrettyDioLogger());

    // Store context for interceptor to use for locale
    _dio.options.extra['context'] = context;
  }

  Dio get dio => _dio;
}
