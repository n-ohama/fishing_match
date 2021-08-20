import 'package:shared_preferences/shared_preferences.dart';

class SharedModel {
  static String loggedInKey = "loggedInKey";
  static String uidKey = "uidKey";
  static String nameKey = "nameKey";
  static String emailKey = "emailKey";

  static Future<bool> saveLoggedIn(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(loggedInKey, isLoggedIn);
  }

  static Future<bool> saveUid(String uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(uidKey, uid);
  }

  static Future<bool> saveUserEmail(String userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(emailKey, userEmail);
  }

  // static Future<bool> saveUsername(String username) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return await prefs.setString(nameKey, username);
  // }

  static Future<bool?> getLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(loggedInKey);
  }

  static Future<String?> getUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(uidKey);
  }

  static Future<String?> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(emailKey);
  }

  // static Future<String?> getUsername() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString(nameKey);
  // }
}
