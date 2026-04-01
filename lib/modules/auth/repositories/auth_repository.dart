import 'package:template_app_flutter/core/models/api_response.dart';
import 'package:template_app_flutter/core/services/public_auth.dart';
import 'package:template_app_flutter/core/services/app_logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/authorize.dart';
import '../models/authorize_request.dart';
import '../models/refresh_token_request.dart';
import '../models/token.dart';
import '../models/token_request.dart';

class AuthRepository {
  final logger = AppLogger.instance;
  final PublicAuth _publicAuth;

  AuthRepository({required BuildContext context, PublicAuth? apiClient})
    : _publicAuth = apiClient ?? PublicAuth(context: context);

  Future<Authorize> postAuthorize(
    AuthorizeRequest authorizeRequest,
    String idToken,
  ) async {
    try {
      final url = '/v1/auth/authorize';
      final response = await _publicAuth.dio.post(
        url,
        data: authorizeRequest.toJson(),
        options: Options(headers: {'Authorization': 'Bearer $idToken'}),
      );

      if (response.statusCode == 201) {
        final res = ApiResponse<Authorize>.fromJson(
          response.data,
          (data) => Authorize.fromJson(data),
        );

        return res.data;
      } else {
        throw Exception(
          'Failed to authorize: ${response.statusCode} ${response.statusMessage}',
        );
      }
    } catch (e) {
      logger.e('Error during authorization: $e');
      throw Exception('Error during authorization: $e');
    }
  }

  Future<Token> postToken(TokenRequest tokenRequest) async {
    try {
      final url = '/v1/auth/token';
      final response = await _publicAuth.dio.post(
        url,
        data: tokenRequest.toJson(),
      );

      if (response.statusCode == 201) {
        final res = ApiResponse<Token>.fromJson(
          response.data,
          (data) => Token.fromJson(data),
        );

        return res.data;
      } else {
        throw Exception(
          'Failed to get token: ${response.statusCode} ${response.statusMessage}',
        );
      }
    } catch (e) {
      logger.e('Error during token retrieval: $e');
      throw Exception('Error during token retrieval: $e');
    }
  }

  Future<Token> postRefreshToken(
    RefreshTokenRequest refreshTokenRequest,
  ) async {
    try {
      final url = '/v1/auth/refresh-token';
      final response = await _publicAuth.dio.post(
        url,
        data: refreshTokenRequest.toJson(),
      );

      if (response.statusCode == 201) {
        final res = ApiResponse<Token>.fromJson(
          response.data,
          (data) => Token.fromJson(data),
        );

        return res.data;
      } else {
        throw Exception(
          'Failed to refresh token: ${response.statusCode} ${response.statusMessage}',
        );
      }
    } catch (e) {
      logger.e('Error during token refresh: $e');
      throw Exception('Error during token refresh: $e');
    }
  }
}
