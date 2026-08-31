import 'package:dio/dio.dart';
import 'package:template_app_flutter/core/exceptions/app_exception.dart';
import 'package:template_app_flutter/core/models/api_response.dart';
import 'package:template_app_flutter/core/services/app_logger.dart';
import 'package:template_app_flutter/core/services/private_api.dart';

import '../models/profile_image.dart';

class ProfileImageRepository {
  final PrivateApi _privateApi;
  static final _logger = AppLogger.instance;
  static const _baseEndpoint = '/v1/profile-images';

  ProfileImageRepository({required PrivateApi privateApi})
    : _privateApi = privateApi;

  Future<ProfileImage> uploadProfileImage({
    required String profileId,
    required String filePath,
  }) async {
    try {
      final endpoint = '$_baseEndpoint/$profileId';
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath),
      });

      final response = await _privateApi.dio.post(endpoint, data: formData);

      final res = ApiResponse<ProfileImage>.fromJson(
        response.data,
        (data) => ProfileImage.fromJson(data),
      );

      return res.data;
    } on DioException catch (e) {
      // Handle 401 - retry
      if (e.response?.statusCode == 401) {
        try {
          return await _retryUploadAfterTokenRefresh(
            filePath: filePath,
            profileId: profileId,
          );
        } catch (refreshError) {
          throw Exception('Token refresh failed');
        }
      }

      _logger.e('request_failed: upload profile image request failed');
      throw AppException('error.request_failed');
    } on Exception {
      _logger.e('unexpected: upload profile image request failed');
      throw AppException('error.unexpected');
    }
  }

  Future<ProfileImage> _retryUploadAfterTokenRefresh({
    required String profileId,
    required String filePath,
  }) async {
    try {
      final endpoint = '$_baseEndpoint/$profileId';
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath),
      });
      final retryResponse = await _privateApi.dio.post(
        endpoint,
        data: formData,
      );

      final res = ApiResponse<ProfileImage>.fromJson(
        retryResponse.data,
        (data) => ProfileImage.fromJson(data),
      );

      return res.data;
    } on DioException {
      _logger.e('request_failed: retry upload profile image request failed');
      throw AppException('error.request_failed');
    } on Exception {
      _logger.e('unexpected: retry upload profile image request failed');
      throw AppException('error.unexpected');
    }
  }
}
