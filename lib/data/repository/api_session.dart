import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/login_model.dart';

class ApiSession {
  static Future<ResponseLogin> getUser() async {
    try {
      ResponseLogin user = ResponseLogin();
      final prefs = await SharedPreferences.getInstance();
      String? stringUser = prefs.getString('userId');
      if (stringUser != null) {
        Map<String, dynamic> mapUser = jsonDecode(stringUser);
        user = ResponseLogin.fromJson(mapUser);
      }
      return user;
    } catch (e) {
      print('Error getting user: $e');
      rethrow;
    }
  }

  static Future<bool> saveUser(ResponseLogin login) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      Map<dynamic, dynamic> mapUser = login.toJson();
      String stringUser = jsonEncode(mapUser);
      bool success = await prefs.setString('userId', stringUser);
      return success;
    } catch (e) {
      print('Error setting user: $e');
      rethrow;
    }
  }

  static Future<bool> clearUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      bool success = await prefs.remove('userId');
      return success;
    } catch (e) {
      print('Error clearing user: $e');
      return false;
    }
  }
}
