import 'package:dio/dio.dart';
import 'package:template_app_flutter/core/exceptions/app_exception.dart';
import 'package:template_app_flutter/core/models/api_response.dart';
import 'package:template_app_flutter/core/services/app_logger.dart';
import 'package:template_app_flutter/core/services/private_image.dart';
import 'package:template_app_flutter/core/utils/image_util.dart';

import '../models/profile_image.dart';

class ProfileImageRepository {
  static final _logger = AppLogger.instance;
  final PrivateImage _privateImage;

  ProfileImageRepository({required PrivateImage privateImage})
    : _privateImage = privateImage;

  Future<ProfileImage> uploadProfileImage({
    required String filePath,
    required String fileName,
    required String profileId,
  }) async {
    try {
      final url = '/v1/profile-images';
      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(filePath, filename: fileName),
      });

      final response = await _privateImage.dio.post(url, data: formData);

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
            fileName: fileName,
          );
        } catch (refreshError) {
          throw Exception('Token refresh failed: $refreshError');
        }
      }

      _logger.e('DioError: ${e.message}');
      throw AppException('error.network');
    } on Exception catch (e) {
      _logger.e('Unknown error: $e');
      throw AppException('error.unknown');
    }
  }

  Future<ProfileImage> _retryUploadAfterTokenRefresh({
    required String filePath,
    required String fileName,
  }) async {
    try {
      final url = "/v1/profile-images";
      final additionalFields = {'feature': 'feature_moments'};
      final formData = await createFormData(
        filePath,
        fileName,
        additionalFields: additionalFields,
      );
      final retryResponse = await _privateImage.dio.post(url, data: formData);

      final res = ApiResponse<ProfileImage>.fromJson(
        retryResponse.data,
        (data) => ProfileImage.fromJson(data),
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
