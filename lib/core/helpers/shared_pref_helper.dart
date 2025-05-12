import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  // private constructor as I don't want to allow creating an instance of this class itself.
  SharedPrefHelper._();
  static FlutterSecureStorage storage = const FlutterSecureStorage();

  /// Removes a value from SharedPreferences with given [key].
  static Future<void> removeData(String key) async {
    log('SharedPrefHelper : data with key : $key has been removed');
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.remove(key);
  }

  /// Removes all keys and values in the SharedPreferences
  static Future<void> clearAllData() async {
    log('SharedPrefHelper : all data has been cleared');
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }

  /// Saves a [value] with a [key] in the SharedPreferences.
  static Future<void> setData(String key, dynamic value) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    log('SharedPrefHelper : setData with key : $key and value : $value');
    switch (value.runtimeType) {
      case const (String):
        await sharedPreferences.setString(key, value as String);
      case const (int):
        await sharedPreferences.setInt(key, value as int);
      case const (bool):
        await sharedPreferences.setBool(key, value as bool);
      case const (double):
        await sharedPreferences.setDouble(key, value as double);
      default:
        return;
    }
  }

  /// Gets a bool value from SharedPreferences with given [key].
  static Future<bool> getBool(String key) async {
    log('SharedPrefHelper : getBool with key : $key');
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(key) ?? false;
  }

  /// Gets a double value from SharedPreferences with given [key].
  static Future<double> getDouble(String key) async {
    log('SharedPrefHelper : getDouble with key : $key');
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getDouble(key) ?? 0.0;
  }

  /// Gets an int value from SharedPreferences with given [key].
  static Future<int> getInt(String key) async {
    log('SharedPrefHelper : getInt with key : $key');
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt(key) ?? 0;
  }

  /// Gets an String value from SharedPreferences with given [key].
  static Future<String> getString(String key) async {
    log('SharedPrefHelper : getString with key : $key');
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key) ?? '';
  }

  /// Saves a [value] with a [key] in the FlutterSecureStorage.
  static Future<void> setSecuredString(String key, String value) async {
    try {
      log('FlutterSecureStorage : setSecuredString with key: $key, value: $value');
      await storage.write(key: key, value: value);
    } catch (e) {
      log('Error in setSecuredString: $e');
    }
  }

  /// Gets an String value from FlutterSecureStorage with given [key].
  static Future<String?> getSecuredString(String key) async {
    try {
      log('FlutterSecureStorage : getSecuredString with key: $key');
      final value = await storage.read(key: key);
      log('FlutterSecureStorage : value retrieved: $value');
      return value;
    } catch (e) {
      log('Error in getSecuredString: $e');
      return null;
    }
  }

  /// Removes a value from FlutterSecureStorage with given [key]
  static Future<void> removeSecuredString(String key) async {
    log('FlutterSecureStorage : data with key : $key has been removed');
    const flutterSecureStorage = FlutterSecureStorage();
    await flutterSecureStorage.delete(key: key);
  }

  /// Removes all keys and values in the FlutterSecureStorage
  static Future<void> clearAllSecuredData() async {
    log('FlutterSecureStorage : all data has been cleared');
    const flutterSecureStorage = FlutterSecureStorage();
    await flutterSecureStorage.deleteAll();
  }
}
