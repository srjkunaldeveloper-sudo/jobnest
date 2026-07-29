import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Service for interacting with secure on-device storage.
///
/// SOLID: Dependency Inversion - Depends on abstractions via dependency injection,
/// decoupling the storage mechanism from the rest of the application.
class SecureStorage {
  final FlutterSecureStorage _storage;

  /// Injects the underlying FlutterSecureStorage instance.
  SecureStorage(this._storage);

  /// Writes a key-value pair to secure storage.
  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  /// Reads a value from secure storage by its key.
  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  /// Deletes a value from secure storage by its key.
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  /// Clears all values from secure storage.
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
