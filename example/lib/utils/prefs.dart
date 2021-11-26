import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static SharedPreferences? _prefs;

  static Future _init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static Future<Set<String>> getKeys() async {
    await _init();
    return _prefs!.getKeys();
  }

  static Future<Object?> get(String key) async {
    await _init();
    return _prefs!.get(key);
  }

  static Future<bool?> getBool(String key) async {
    await _init();
    return _prefs!.getBool(key);
  }

  static Future<int?> getInt(String key) async {
    await _init();
    return _prefs!.getInt(key);
  }

  static Future<double?> getDouble(String key) async {
    await _init();
    return _prefs!.getDouble(key);
  }

  static Future<String?> getString(String key) async {
    await _init();
    return _prefs!.getString(key);
  }

  static Future<bool> containsKey(String key) async {
    await _init();
    return _prefs!.containsKey(key);
  }

  static Future<List<String>?> getStringList(String key) async {
    await _init();
    return _prefs!.getStringList(key);
  }

  static Future<bool> setBool(String key, bool value) async {
    await _init();
    return await _prefs!.setBool(key, value);
  }

  static Future<bool> setInt(String key, int value) async {
    await _init();
    return await _prefs!.setInt(key, value);
  }

  static Future<bool> setDouble(String key, double value) async {
    await _init();
    return await _prefs!.setDouble(key, value);
  }

  static Future<bool> setString(String key, String value) async {
    await _init();
    return await _prefs!.setString(key, value);
  }

  static Future<bool> setStringList(String key, List<String> value) async {
    await _init();
    return await _prefs!.setStringList(key, value);
  }

  static Future<bool> remove(String key) async {
    await _init();
    return await _prefs!.remove(key);
  }

  static Future<bool> clear() async {
    await _init();
    return await _prefs!.clear();
  }

  static Future<void> reload() async {
    await _init();
    await _prefs!.reload();
  }
}
