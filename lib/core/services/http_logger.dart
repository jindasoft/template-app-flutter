import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:template_app_flutter/configs/env_config.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class HttpLogger {
  static void attach(Dio dio) {
    if (!kDebugMode || !EnvConfig.logHttpEnabled) return;

    final allowlist = EnvConfig.logHttpAllowlist;
    final denylist = EnvConfig.logHttpDenylist;
    final sensitiveEndpoints = EnvConfig.logHttpSensitiveEndpoints;

    dio.interceptors.add(
      PrettyDioLogger(
        request: true,
        requestHeader: false,
        requestBody: false,
        responseHeader: false,
        responseBody: true,
        error: true,
        filter: (options, _) => _shouldLog(
          options.uri,
          allowlist: allowlist,
          denylist: denylist,
          sensitiveEndpoints: sensitiveEndpoints,
        ),
      ),
    );
  }

  static bool _isSensitiveEndpoint(Uri uri, List<String> sensitiveEndpoints) {
    final path = uri.path.toLowerCase();
    return sensitiveEndpoints.any((pattern) {
      final normalized = pattern.trim();
      if (normalized.isEmpty) return false;
      try {
        return RegExp(normalized, caseSensitive: false).hasMatch(path);
      } catch (_) {
        return path.contains(normalized.toLowerCase());
      }
    });
  }

  static bool _shouldLog(
    Uri uri, {
    required List<String> allowlist,
    required List<String> denylist,
    required List<String> sensitiveEndpoints,
  }) {
    if (_isSensitiveEndpoint(uri, sensitiveEndpoints)) return false;

    final normalizedPath = uri.path.toLowerCase();
    final denied = denylist.any(
      (pattern) =>
          pattern.isNotEmpty && normalizedPath.contains(pattern.toLowerCase()),
    );
    if (denied) return false;

    if (allowlist.isEmpty) return true;
    return allowlist.any(
      (pattern) =>
          pattern.isNotEmpty && normalizedPath.contains(pattern.toLowerCase()),
    );
  }
}
