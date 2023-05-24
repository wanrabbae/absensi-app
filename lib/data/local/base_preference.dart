// import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BasePreference {
  static SharedPreferences? _preferences;
  // static FlutterSecureStorage? _secureStorage;

  static BasePreference? _instance;

  const BasePreference._();

  static BasePreference get instance => _instance ?? const BasePreference._();

  static Future<void> init() async {
    // EncryptedSharedPreferences encryptedSharedPreferences =
    //     EncryptedSharedPreferences(
    //         prefs: await SharedPreferences.getInstance());

    // _preferences ??= await encryptedSharedPreferences.getInstance();
    // _secureStorage ??= const FlutterSecureStorage();
  }

  T? getPref<T>(String key) {
    try {
      switch (T) {
        case String:
          return _preferences!.getString(key) as T?;
        case int:
          return _preferences!.getInt(key) as T?;
        case bool:
          return _preferences!.getBool(key) as T?;
        case double:
          return _preferences!.getDouble(key) as T?;
        default:
          return _preferences!.get(key) as T?;
      }
    } on Exception {
      return null;
    }
  }

  Future<bool> setPref<T>(String key, T value) {
    switch (T) {
      case String:
        return _preferences!.setString(key, value as String);
      case int:
        return _preferences!.setInt(key, value as int);
      case bool:
        return _preferences!.setBool(key, value as bool);
      case double:
        return _preferences!.setDouble(key, value as double);
      default:
        return _preferences!.setString(key, value as String);
    }
  }

  // Future<String?> getEncrypted(String key) {
  //   try {
  //     return _secureStorage!.read(key: key);
  //   } on PlatformException {
  //     return Future<String?>.value(null);
  //   }
  // }

  // Future<bool> setEncrypted(String key, String value) {
  //   try {
  //     _secureStorage!.write(key: key, value: value);
  //     return Future.value(true);
  //   } on PlatformException catch (_) {
  //     return Future.value(false);
  //   }
  // }

  // Future<bool> clearPref() => _preferences!.clear();

  // Future<bool> clearEncrypted() async {
  //   try {
  //     await _secureStorage!.deleteAll();
  //     return true;
  //   } on PlatformException catch (_) {
  //     return false;
  //   }
  // }
}
