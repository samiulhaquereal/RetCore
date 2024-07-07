import 'dart:developer' as dev;
import 'package:retcore/src/config/imports.dart';

class SharedServices {

  static SharedServices? _instance;
  SharedServices._internal();
  factory SharedServices(){
    _instance ??= SharedServices._internal();
    return _instance!;
  }

  static Future<void> setData({
    required RetCoreLocalStorageType type,
    required String key,
    required dynamic value,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    switch (type) {
      case RetCoreLocalStorageType.string:
        await prefs.setString(key, value as String);
        break;
      case RetCoreLocalStorageType.int:
        await prefs.setInt(key, value as int);
        break;
      case RetCoreLocalStorageType.bool:
        await prefs.setBool(key, value as bool);
        break;
      case RetCoreLocalStorageType.double:
        await prefs.setDouble(key, value as double);
        break;
      case RetCoreLocalStorageType.stringList:
        await prefs.setStringList(key, value as List<String>);
        break;
    }
    dev.log('Key: $key value: $value saved');
  }

  static Future<dynamic> getData({
    required RetCoreLocalStorageType type,
    required String key,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    dynamic data;

    switch (type) {
      case RetCoreLocalStorageType.string:
        data = prefs.getString(key);
        break;
      case RetCoreLocalStorageType.int:
        data = prefs.getInt(key);
        break;
      case RetCoreLocalStorageType.bool:
        data = prefs.getBool(key);
        break;
      case RetCoreLocalStorageType.double:
        data = prefs.getDouble(key);
        break;
      case RetCoreLocalStorageType.stringList:
        data = prefs.getStringList(key);
        break;
    }

    dev.log('Key: $key Value: $data');
    return data;
  }

  static Future<void> removeData({required String key}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
    dev.log('Key: $key removed');
  }
}