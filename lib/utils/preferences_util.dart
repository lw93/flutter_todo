import 'package:shared_preferences/shared_preferences.dart';

class PreferencesUtil {
  static saveMessageByDouble(String key, double value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setDouble(key, value);
  }

  static saveMessageByStr(String key, String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(key, value);
  }

  static saveMessageByBool(String key, bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(key, value);
  }

  static Future<double> getMessageByDouble(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getDouble(key);
  }

  static Future<String> getMessageByStr(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key);
  }

  static Future<bool> getMessageByBool(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.get(key);
  }
}

class PreferencesKeys {
  static const String showGuide = "showGuide";
  static const String userName = "userName";
  static const String userId = "userId";
  static const String pass = "pass";
  static const String emailEveryDayEable = "emailDaliy";
}
