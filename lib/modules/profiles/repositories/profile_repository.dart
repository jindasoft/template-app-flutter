import 'package:dio/dio.dart';
import 'package:template_app_flutter/core/exceptions/app_exception.dart';
import 'package:template_app_flutter/core/models/api_response.dart';
import 'package:template_app_flutter/core/services/app_logger.dart';
import 'package:template_app_flutter/core/services/private_api.dart';

import '../models/profile_detail.dart';
import '../models/profile_edit.dart';

class ProfileRepository {
  static final _logger = AppLogger.instance;
  final PrivateApi _privateApi;

  ProfileRepository({required PrivateApi privateApi})
    : _privateApi = privateApi;

  Future<ProfileDetail> getProfileById(String id) async {
    try {
      final url = '/v1/profiles/$id';
      final response = await _privateApi.dio.get(url);
      final res = ApiResponse<ProfileDetail>.fromJson(
        response.data,
        (data) => ProfileDetail.fromJson(data),
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

  Future<ProfileDetail> updateProfile(ProfileEdit profileEdit) async {
    try {
      final url = '/v1/profiles/${profileEdit.id}';
      final response = await _privateApi.dio.put(
        url,
        data: profileEdit.toJson(),
      );
      final res = ApiResponse<ProfileDetail>.fromJson(
        response.data,
        (data) => ProfileDetail.fromJson(data),
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
