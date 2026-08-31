import 'package:template_app_flutter/configs/app_config.dart';
import 'package:template_app_flutter/core/constants/http_header.dart';
import 'package:template_app_flutter/core/services/public_auth.dart';
import 'package:template_app_flutter/modules/auth/models/refresh_token_request.dart';
import 'package:template_app_flutter/modules/auth/repositories/auth_repository.dart';
import 'package:template_app_flutter/modules/auth/services/token_service.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PrivateInterceptor extends Interceptor {
  bool _isRefreshing = false;
  Dio? _dioInstance;

  void setDio(Dio dio) {
    _dioInstance = dio;
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final locale =
        EasyLocalization.of(options.extra['context'])?.locale ??
        AppConfig.defaultLanguage;
    final accessToken = await TokenService.getAccessToken();

    final headers = {
      HttpHeader.acceptLanguage: locale.toLanguageTag(),
      HttpHeader.authorization: 'Bearer $accessToken',
    };
    options.headers.addAll(headers);

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // If response is 401, refresh the token and retry
    if (err.response?.statusCode == 401 && !_isRefreshing) {
      _handleTokenRefresh(err, handler);
    } else {
      handler.next(err);
    }
  }

  Future<void> _handleTokenRefresh(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    _isRefreshing = true;
    try {
      final BuildContext? context =
          err.requestOptions.extra['context'] as BuildContext?;
      final PublicAuth publicAuth = PublicAuth(context: context!);
      final AuthRepository authRepository = AuthRepository(
        publicAuth: publicAuth,
      );

      // refresh token
      final tokenRequest = RefreshTokenRequest(
        refreshToken: await TokenService.getRefreshToken(),
      );
      final token = await authRepository.postRefreshToken(tokenRequest);

      // save new tokens
      await TokenService.saveAccessToken(token.accessToken);
      await TokenService.saveRefreshToken(token.refreshToken);

      // retry original request with new token
      // set new token with onRequest
      final opts = err.requestOptions;
      final response = await _dioInstance!.fetch(opts);
      handler.resolve(response);
    } catch (e) {
      if (e is StateError) {
        await TokenService.clearSession();
      }
      handler.next(err);
    } finally {
      _isRefreshing = false;
    }
  }
}
