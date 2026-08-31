import 'package:template_app_flutter/configs/app_config.dart';
import 'package:dio/dio.dart';
import 'package:template_app_flutter/core/constants/http_header.dart';
import 'package:template_app_flutter/core/exceptions/app_exception.dart';
import 'package:template_app_flutter/core/models/api_response.dart';
import 'package:template_app_flutter/core/services/public_auth.dart';
import 'package:template_app_flutter/core/services/app_logger.dart';
import 'package:template_app_flutter/modules/auth/models/sign_out_request.dart';

import '../models/authorize_response.dart';
import '../models/delete_account_request.dart';
import '../models/authorize_request.dart';
import '../models/refresh_token_request.dart';
import '../models/token_response.dart';
import '../models/token_request.dart';
import '../services/device_service.dart';
import '../services/token_service.dart';

class AuthRepository {
  final PublicAuth _publicAuth;
  static final _logger = AppLogger.instance;
  static const _baseEndpoint = '/v1/auth';

  AuthRepository({required PublicAuth publicAuth}) : _publicAuth = publicAuth;

  Future<AuthorizeResponse> postAuthorize(
    AuthorizeRequest authorizeRequest,
    String firebaseIdToken,
  ) async {
    try {
      final endpoint = '$_baseEndpoint/authorize';
      final headers = {
        HttpHeader.authorization: 'Bearer $firebaseIdToken',
        HttpHeader.platform: AppConfig.platform,
        HttpHeader.deviceId: await DeviceService.getDeviceId(),
      };

      final response = await _publicAuth.dio.post(
        endpoint,
        data: authorizeRequest.toJson(),
        options: Options(headers: headers),
      );

      final res = ApiResponse<AuthorizeResponse>.fromJson(
        response.data,
        (data) => AuthorizeResponse.fromJson(data),
      );

      // Persist the instance ID for future requests.
      final instanceId = response.headers[HttpHeader.instanceId]?.first ?? '';
      DeviceService.saveInstanceId(instanceId);

      return res.data;
    } on DioException {
      _logger.e('request_failed: authorize request failed');
      throw AppException('error.request_failed');
    } on Exception {
      _logger.e('unexpected: authorize request failed');
      throw AppException('error.unexpected');
    }
  }

  Future<TokenResponse> postToken(TokenRequest tokenRequest) async {
    try {
      final endpoint = '$_baseEndpoint/token';
      final headers = {
        HttpHeader.deviceId: await DeviceService.getDeviceId(),
        HttpHeader.instanceId: await DeviceService.getInstanceId(),
      };

      final response = await _publicAuth.dio.post(
        endpoint,
        data: tokenRequest.toJson(),
        options: Options(headers: headers),
      );

      final res = ApiResponse<TokenResponse>.fromJson(
        response.data,
        (data) => TokenResponse.fromJson(data),
      );

      return res.data;
    } on DioException {
      _logger.e('request_failed: token request failed');
      throw AppException('error.request_failed');
    } on Exception {
      _logger.e('unexpected: token request failed');
      throw AppException('error.unexpected');
    }
  }

  Future<TokenResponse> postRefreshToken(
    RefreshTokenRequest refreshTokenRequest,
  ) async {
    try {
      final endpoint = '$_baseEndpoint/refresh-token';
      final headers = {
        HttpHeader.deviceId: await DeviceService.getDeviceId(),
        HttpHeader.instanceId: await DeviceService.getInstanceId(),
      };

      final response = await _publicAuth.dio.post(
        endpoint,
        data: refreshTokenRequest.toJson(),
        options: Options(headers: headers),
      );

      final res = ApiResponse<TokenResponse>.fromJson(
        response.data,
        (data) => TokenResponse.fromJson(data),
      );

      return res.data;
    } on DioException {
      _logger.e('request_failed: refresh token request failed');
      throw AppException('error.request_failed');
    } on Exception {
      _logger.e('unexpected: refresh token request failed');
      throw AppException('error.unexpected');
    }
  }

  Future<void> postSignOut(SignOutRequest signOutRequest) async {
    try {
      final endpoint = '$_baseEndpoint/sign-out';
      final headers = {
        HttpHeader.deviceId: await DeviceService.getDeviceId(),
        HttpHeader.instanceId: await DeviceService.getInstanceId(),
      };

      await _publicAuth.dio.post(
        endpoint,
        data: signOutRequest.toJson(),
        options: Options(headers: headers),
      );
    } on DioException {
      _logger.e('request_failed: sign out request failed');
      throw AppException('error.request_failed');
    } on Exception {
      _logger.e('unexpected: sign out request failed');
      throw AppException('error.unexpected');
    }
  }

  Future<void> deleteAccount(DeleteAccountRequest deleteAccountRequest) async {
    try {
      await _sendDeleteAccount(deleteAccountRequest);
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        // Access token expired right before the call — refresh once and retry.
        final refreshed = await postRefreshToken(
          RefreshTokenRequest(refreshToken: deleteAccountRequest.refreshToken),
        );
        await TokenService.saveAccessToken(refreshed.accessToken);
        await TokenService.saveRefreshToken(refreshed.refreshToken);
        await _sendDeleteAccount(deleteAccountRequest);
        return;
      }
      _logger.e('request_failed: delete account request failed');
      throw AppException('error.request_failed');
    } on Exception {
      _logger.e('unexpected: delete account request failed');
      throw AppException('error.unexpected');
    }
  }

  Future<void> _sendDeleteAccount(
    DeleteAccountRequest deleteAccountRequest,
  ) async {
    final endpoint = '$_baseEndpoint/delete-account';
    final accessToken = await TokenService.getAccessToken();
    final headers = {
      HttpHeader.authorization: 'Bearer $accessToken',
      HttpHeader.deviceId: await DeviceService.getDeviceId(),
      HttpHeader.instanceId: await DeviceService.getInstanceId(),
    };

    await _publicAuth.dio.delete(
      endpoint,
      data: deleteAccountRequest.toJson(),
      options: Options(headers: headers),
    );
  }
}
