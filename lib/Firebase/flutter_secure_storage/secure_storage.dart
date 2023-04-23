import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FSS {
  final _storage = const FlutterSecureStorage();

  Future<void> saveData(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> getData(String key) {
    try {
      final value = _storage.read(key: key);
      return value;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteData(String key) async {
    try {
      await _storage.delete(key: key);
    } catch (e) {
      rethrow;
    }
  }
}
