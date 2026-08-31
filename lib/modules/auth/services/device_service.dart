import 'dart:math';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DeviceService {
  static final _storage = FlutterSecureStorage();
  static const _deviceIdKey = 'device_id';
  static const _instanceIdKey = 'instance_id';

  // Persists a generated UUID so the same device keeps the same ID across app runs.
  static Future<String> getDeviceId() async {
    final existing = await _storage.read(key: _deviceIdKey);
    if (existing != null && existing.isNotEmpty) {
      return existing;
    }

    final deviceId = _generateUuidV4();
    await _storage.write(key: _deviceIdKey, value: deviceId);
    return deviceId;
  }

  static Future<void> deleteDeviceId() async {
    await _storage.delete(key: _deviceIdKey);
  }

  // instanceId
  static Future<String> getInstanceId() async {
    final value = await _storage.read(key: _instanceIdKey);
    if (value == null || value.isEmpty) {
      throw StateError('Missing $_instanceIdKey in secure storage.');
    }

    return value;
  }

  static Future<void> saveInstanceId(String instanceId) async {
    await _storage.write(key: _instanceIdKey, value: instanceId);
  }

  static Future<void> deleteInstanceId() async {
    await _storage.delete(key: _instanceIdKey);
  }

  // clear session
  static Future<void> clearSession() async {
    await Future.wait([deleteDeviceId(), deleteInstanceId()]);
  }

  static String _generateUuidV4() {
    final rand = Random.secure();
    final bytes = List<int>.generate(16, (_) => rand.nextInt(256));

    bytes[6] = (bytes[6] & 0x0f) | 0x40; // version 4
    bytes[8] = (bytes[8] & 0x3f) | 0x80; // variant 1

    String hex(int start, int end) => bytes
        .sublist(start, end)
        .map((b) => b.toRadixString(16).padLeft(2, '0'))
        .join();

    return '${hex(0, 4)}-${hex(4, 6)}-${hex(6, 8)}-${hex(8, 10)}-${hex(10, 16)}';
  }
}
