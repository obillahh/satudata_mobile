import 'package:shared_preferences/shared_preferences.dart';

class HttpSession {
  static Future<bool> saveToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    bool succes = await pref.setString('token', token);
    return succes;
  }

  static Future<String> getToken() async {
    final pref = await SharedPreferences.getInstance();
    String? stringUser = pref.getString('token');
    if (stringUser != null) {
      return stringUser;
    }
    return '';
  }

  static Future<bool> clearToken() async {
    final pref = await SharedPreferences.getInstance();
    bool succes = await pref.remove('token');
    return succes;
  }
}
