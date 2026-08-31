import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';

class PkceService {
  static final _verifierPattern = RegExp(r'^[A-Za-z0-9\-._~]{43,128}$');
  static const _minVerifierLength = 43;
  static const _maxVerifierLength = 128;

  static String getVerifierCode([int length = 43]) {
    _validateVerifierLength(length);

    final rand = Random.secure();
    final chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~';
    return List.generate(
      length,
      (_) => chars[rand.nextInt(chars.length)],
    ).join();
  }

  static String getChallengeCode(String verifierCode) {
    _validateVerifierCode(verifierCode);

    final bytes = utf8.encode(verifierCode);
    final digest = sha256.convert(bytes);
    return base64UrlEncode(digest.bytes).replaceAll('=', '');
  }

  static void _validateVerifierCode(String verifierCode) {
    if (!_verifierPattern.hasMatch(verifierCode)) {
      throw ArgumentError.value(
        verifierCode,
        'verifierCode',
        'PKCE code verifier must be 43-128 chars and use only RFC 7636 unreserved characters.',
      );
    }
  }

  static void _validateVerifierLength(int length) {
    if (length < _minVerifierLength || length > _maxVerifierLength) {
      throw ArgumentError.value(
        length,
        'length',
        'PKCE code verifier length must be between 43 and 128 characters.',
      );
    }
  }
}
