import 'package:shared_preferences/shared_preferences.dart';

/// A service class that provide methods to store a non-protected or secure data
///
/// its interact with SharePreferences class and stores data
///
/// Example usage:
/// ```Dart
/// final storageService = StorageService(sharedPref: await SharedPreferences.getInstance(),);
///

class StorageService {
  StorageService({required this.preferences});

  /// Shared preferences instance
  final SharedPreferences preferences;

  /// Set string value
  Future<void> setString(String key, String value) async {
    await preferences.setString(key, value);
  }

  /// Get string value
  String? getString(String key) {
    final res = preferences.getString(key);
    if (res?.toLowerCase() == 'null') {
      return null;
    }
    return res;
  }

  /// Set int value
  Future<void> setInt(String key, int value) async {
    await preferences.setInt(key, value);
  }

  /// Get int value
  int? getInt(String key) {
    return preferences.getInt(key);
  }

  /// Set double value
  Future<void> setDouble(String key, double value) async {
    await preferences.setDouble(key, value);
  }

  /// Get double value
  double? getDouble(String key) {
    return preferences.getDouble(key);
  }

  /// Set bool value
  Future<void> setBool(String key, bool value) async {
    await preferences.setBool(key, value);
  }

  /// Get bool value
  bool? getBool(String key) {
    return preferences.getBool(key);
  }

  /// Set list value
  Future<void> setList(String key, List<String> value) async {
    await preferences.setStringList(key, value);
  }

  /// Get list value
  List<String>? getList(String key) {
    return preferences.getStringList(key);
  }

  /// Remove value
  Future<void> remove(String key) async {
    await preferences.remove(key);
  }

  /// Clear all data
  Future<void> clear() async {
    await preferences.clear();
  }
}
