import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RefreshCredentials {
  final String refreshToken;
  final String verifierCode;

  const RefreshCredentials({
    required this.refreshToken,
    required this.verifierCode,
  });
}

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

  static Future<String> getRequiredAccessToken() async =>
      _readRequiredValue(key: accessToken, label: 'access token');

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

  static Future<RefreshCredentials> getRequiredRefreshCredentials() async {
    return RefreshCredentials(
      refreshToken: await _readRequiredValue(
        key: refreshToken,
        label: 'refresh token',
      ),
      verifierCode: await _readRequiredValue(
        key: verifierCode,
        label: 'verifier code',
      ),
    );
  }

  static Future<void> clearSession() async {
    await Future.wait([
      deleteAccessToken(),
      deleteRefreshToken(),
      deleteVerifierCode(),
    ]);
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
