import 'package:dio/dio.dart';
import 'package:template_app_flutter/core/exceptions/app_exception.dart';
import 'package:template_app_flutter/core/models/api_response.dart';
import 'package:template_app_flutter/core/services/public_auth.dart';
import 'package:template_app_flutter/core/services/app_logger.dart';

import '../models/authorize.dart';
import '../models/authorize_request.dart';
import '../models/refresh_token_request.dart';
import '../models/token.dart';
import '../models/token_request.dart';

class AuthRepository {
  static final _logger = AppLogger.instance;
  final PublicAuth _publicAuth;

  AuthRepository({required PublicAuth publicAuth}) : _publicAuth = publicAuth;

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

      final res = ApiResponse<Authorize>.fromJson(
        response.data,
        (data) => Authorize.fromJson(data),
      );

      return res.data;
    } on DioException catch (e) {
      _logger.e('DioError: ${e.message}');
      throw AppException('error.network');
    } on Exception catch (e) {
      _logger.e('Unknown error: $e');
      throw AppException('error.unknown');
    }
  }

  Future<Token> postToken(TokenRequest tokenRequest) async {
    try {
      final url = '/v1/auth/token';
      final response = await _publicAuth.dio.post(
        url,
        data: tokenRequest.toJson(),
      );

      final res = ApiResponse<Token>.fromJson(
        response.data,
        (data) => Token.fromJson(data),
      );

      return res.data;
    } on DioException catch (e) {
      _logger.e('DioError: ${e.message}');
      throw AppException('error.network');
    } on Exception catch (e) {
      _logger.e('Unknown error: $e');
      throw AppException('error.unknown');
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

      final res = ApiResponse<Token>.fromJson(
        response.data,
        (data) => Token.fromJson(data),
      );

      return res.data;
    } on DioException catch (e) {
      _logger.e('DioError: ${e.message}');
      throw AppException('error.network');
    } on Exception catch (e) {
      _logger.e('Unknown error: $e');
      throw AppException('error.unknown');
    }
  }
}
