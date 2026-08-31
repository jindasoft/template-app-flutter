import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RefreshCredentials {
  final String refreshToken;

  const RefreshCredentials({required this.refreshToken});
}

class TokenService {
  static final _storage = FlutterSecureStorage();
  static const accessTokenKey = 'access_token';
  static const refreshTokenKey = 'refresh_token';

  // Key
  static Future<String> getAccessToken() async =>
      _readRequiredValue(key: accessTokenKey, label: 'access token');

  static Future<void> saveAccessToken(String token) async =>
      await _storage.write(key: accessTokenKey, value: token);

  static Future<void> deleteAccessToken() async =>
      await _storage.delete(key: accessTokenKey);

  // refreshToken
  static Future<String> getRefreshToken() async =>
      _readRequiredValue(key: refreshTokenKey, label: 'refresh token');

  static Future<void> saveRefreshToken(String token) async =>
      await _storage.write(key: refreshTokenKey, value: token);

  static Future<void> deleteRefreshToken() async =>
      await _storage.delete(key: refreshTokenKey);

  // clear session
  static Future<void> clearSession() async {
    await Future.wait([deleteAccessToken(), deleteRefreshToken()]);
  }

  static Future<String> _readRequiredValue({
    required String key,
    required String label,
  }) async {
    final value = await _storage.read(key: key);
    if (value == null || value.isEmpty) {
      throw StateError('Missing $label in secure storage.');
    }

    return value;
  }
}
