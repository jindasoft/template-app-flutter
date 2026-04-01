import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenService {
  static final _storage = FlutterSecureStorage();
  static const accessToken = 'access_token';
  static const refreshToken = 'refresh_token';
  static const verifierCode = 'verifier_code';

  // accessToken
  static Future<void> saveAccessToken(String token) async =>
      await _storage.write(key: accessToken, value: token);

  static Future<String?> getAccessToken() async =>
      await _storage.read(key: accessToken);

  static Future<void> deleteAccessToken() async =>
      await _storage.delete(key: accessToken);

  // refreshToken
  static Future<void> saveRefreshToken(String token) async =>
      await _storage.write(key: refreshToken, value: token);

  static Future<String?> getRefreshToken() async =>
      await _storage.read(key: refreshToken);

  static Future<void> deleteRefreshToken() async =>
      await _storage.delete(key: refreshToken);

  // verifierCode
  static Future<void> saveVerifierCode(String code) async =>
      await _storage.write(key: verifierCode, value: code);

  static Future<String?> getVerifierCode() async =>
      await _storage.read(key: verifierCode);

  static Future<void> deleteVerifierCode() async =>
      await _storage.delete(key: verifierCode);
}
