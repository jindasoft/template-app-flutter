import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static const List<String> _defaultLogHttpSensitiveEndpoints = [
    r'/auth(/|$)',
    r'/login(/|$)',
    r'/logout(/|$)',
    r'/register(/|$)',
    r'/password(/|$)',
    r'/token(/|$)',
    r'/refresh(/|$)',
    r'/otp(/|$)',
    r'/verify(/|$)',
    r'/upload(/|$)',
    r'/payment(/|$)',
  ];

  static final String? forceWelcome = dotenv.env['FORCE_WELCOME'];

  static bool get forceWelcomeEnabled {
    final raw = forceWelcome;
    if (raw == null || raw.trim().isEmpty) return false;
    const truthyValues = {'1', 'true', 'yes', 'on'};
    return truthyValues.contains(raw.trim().toLowerCase());
  }

  static final String? authUrl = dotenv.env['AUTH_URL'];
  static final String? apiUrl = dotenv.env['API_URL'];
  static final String? maptilerApiKey = dotenv.env['MAPTILER_API_KEY'];

  static bool get logHttpEnabled {
    final raw = dotenv.env['LOG_HTTP_ENABLED'];
    if (raw == null || raw.trim().isEmpty) return true;
    const truthyValues = {'1', 'true', 'yes', 'on'};
    return truthyValues.contains(raw.trim().toLowerCase());
  }

  static List<String> get logHttpAllowlist =>
      _csvToList(dotenv.env['LOG_HTTP_ALLOWLIST']);

  static List<String> get logHttpDenylist =>
      _csvToList(dotenv.env['LOG_HTTP_DENYLIST']);

  static List<String> get logHttpSensitiveEndpoints {
    const key = 'LOG_HTTP_SENSITIVE_ENDPOINTS';
    // If key is missing, use safe defaults. If key exists but is empty, use [] by design.
    if (!dotenv.env.containsKey(key)) {
      return _defaultLogHttpSensitiveEndpoints;
    }
    return _csvToList(dotenv.env[key]);
  }

  static List<String> _csvToList(String? value) {
    if (value == null || value.trim().isEmpty) return const [];
    return value
        .split(',')
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .toList(growable: false);
  }

  final String googleServerClientId = dotenv.env['GOOGLE_SERVER_CLIENT_ID']!;
  final String googlePeopleApiUrl = dotenv.env['GOOGLE_PEOPLE_API_URL']!;
}
