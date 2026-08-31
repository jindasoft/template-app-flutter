import 'package:dio/dio.dart';
import 'package:template_app_flutter/core/exceptions/app_exception.dart';
import 'package:template_app_flutter/core/models/api_response.dart';
import 'package:template_app_flutter/core/services/app_logger.dart';
import 'package:template_app_flutter/core/services/private_api.dart';

import '../models/profile_detail.dart';
import '../models/my_profile.dart';
import '../models/profile_edit.dart';

class ProfileRepository {
  final PrivateApi _privateApi;
  static final _logger = AppLogger.instance;
  static const _baseEndpoint = '/v1/profiles';

  ProfileRepository({required PrivateApi privateApi})
    : _privateApi = privateApi;

  Future<MyProfile> getMyProfile() async {
    try {
      final endpoint = '$_baseEndpoint/me';
      final response = await _privateApi.dio.get(endpoint);

      final res = ApiResponse<MyProfile>.fromJson(
        response.data,
        (data) => MyProfile.fromJson(data),
      );

      return res.data;
    } on DioException {
      _logger.e('request_failed: get my profile request failed');
      throw AppException('error.request_failed');
    } on Exception {
      _logger.e('unexpected: get my profile request failed');
      throw AppException('error.unexpected');
    }
  }

  Future<ProfileDetail> getProfileById(String id) async {
    try {
      final endpoint = '$_baseEndpoint/$id';
      final response = await _privateApi.dio.get(endpoint);
      final res = ApiResponse<ProfileDetail>.fromJson(
        response.data,
        (data) => ProfileDetail.fromJson(data),
      );

      return res.data;
    } on DioException {
      _logger.e('request_failed: get profile by id request failed');
      throw AppException('error.request_failed');
    } on Exception {
      _logger.e('unexpected: get profile by id request failed');
      throw AppException('error.unexpected');
    }
  }

  Future<ProfileDetail> updateProfile(
    String profileId,
    ProfileEdit profileEdit,
  ) async {
    try {
      final endpoint = '$_baseEndpoint/$profileId';
      final response = await _privateApi.dio.put(
        endpoint,
        data: profileEdit.toJson(),
      );
      final res = ApiResponse<ProfileDetail>.fromJson(
        response.data,
        (data) => ProfileDetail.fromJson(data),
      );

      return res.data;
    } on DioException {
      _logger.e('request_failed: update profile request failed');
      throw AppException('error.request_failed');
    } on Exception {
      _logger.e('unexpected: update profile request failed');
      throw AppException('error.unexpected');
    }
  }
}
