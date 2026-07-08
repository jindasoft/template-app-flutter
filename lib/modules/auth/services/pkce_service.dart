import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';

class PkceService {
  static const int _minVerifierLength = 43;
  static const int _maxVerifierLength = 128;
  static final RegExp _verifierPattern = RegExp(r'^[A-Za-z0-9\-._~]{43,128}$');

  String generateCodeVerifier([int length = 43]) {
    _validateVerifierLength(length);

    final rand = Random.secure();
    final chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~';
    return List.generate(
      length,
      (_) => chars[rand.nextInt(chars.length)],
    ).join();
  }

  String generateCodeChallenge(String codeVerifier) {
    _validateCodeVerifier(codeVerifier);

    final bytes = utf8.encode(codeVerifier);
    final digest = sha256.convert(bytes);
    return base64UrlEncode(digest.bytes).replaceAll('=', '');
  }

  void _validateCodeVerifier(String codeVerifier) {
    if (!_verifierPattern.hasMatch(codeVerifier)) {
      throw ArgumentError.value(
        codeVerifier,
        'codeVerifier',
        'PKCE code verifier must be 43-128 chars and use only RFC 7636 unreserved characters.',
      );
    }
  }

  void _validateVerifierLength(int length) {
    if (length < _minVerifierLength || length > _maxVerifierLength) {
      throw ArgumentError.value(
        length,
        'length',
        'PKCE code verifier length must be between 43 and 128 characters.',
      );
    }
  }
}
