import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  // 🔑 Keys
  static const String _tokenKey = "auth_token";

  /// SAVE TOKEN
  static Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  /// GET TOKEN
  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  /// REMOVE TOKEN
  static Future<void> removeToken() async {
    await _storage.delete(key: _tokenKey);
  }

  /// CLEAR ALL KEYS (optional)
  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
