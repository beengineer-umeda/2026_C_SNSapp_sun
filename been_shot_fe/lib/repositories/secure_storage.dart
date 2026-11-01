import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  factory SecureStorage() => _instance;
  SecureStorage._createSingleton();
  static final SecureStorage _instance = SecureStorage._createSingleton();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<void> saveToken(String key, String token) async {
    await _secureStorage.write(key: key, value: token);
  }

  Future<String?> getToken(String key) async {
    return _secureStorage.read(key: key);
  }

  Future<void> deleteAllToken() async {
    return _secureStorage.deleteAll();
  }
}
