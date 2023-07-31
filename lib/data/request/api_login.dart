import 'dart:convert';

import 'package:satudata_mobile/data/models/login_model.dart';
import 'package:satudata_mobile/data/repository/api.dart';
import 'package:satudata_mobile/data/repository/api_request.dart';
import 'package:satudata_mobile/data/repository/api_session.dart';

class ApiUser {
  static Future<ResponseLogin> login(String email, String password) async {
    try {
      final responseBody = await ApiRequest.postLogin(
        Api.login,
        jsonEncode({'email': email, 'password': password}),
      );
      ApiSession.saveUser(ResponseLogin.fromJson(responseBody!));
      return ResponseLogin.fromJson(responseBody);
    } catch (e) {
      rethrow;
    }
  }

  static Future<Map?> getUserData(int userId) async {
    try {
      var response = await ApiRequest.gets('${Api.users}/$userId');
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
