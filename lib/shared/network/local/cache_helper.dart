
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static init() async{
    sharedPreferences = await SharedPreferences.getInstance();
    // saveData(key: 'isDark', value: false);
  }

  // static Future<bool> setMode({required String key, required bool value}) async{
  //   return await sharedPreferences.setBool(key, value);
  // }

  // static bool? getMode({required String key}) {
  //   return sharedPreferences.getBool(key);
  // }

  static Future<bool> saveData({required key, required value})async{
    if(value is String) {
      return await sharedPreferences.setString(key, value);
    }
    if(value is int) {
      return await sharedPreferences.setInt(key, value);
    }
    if(value is bool) {
      return await sharedPreferences.setBool(key, value);
    }

    return await sharedPreferences.setDouble(key, value);
  }

  static dynamic getData({required key}){
    return sharedPreferences.get(key);
  }

  // clear the value in a specific key
  static Future<bool> removeData({required key}) async{
   return await sharedPreferences.remove(key);
  }
}