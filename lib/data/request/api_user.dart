import 'package:dio/dio.dart';
import 'package:satudata_mobile/data/repository/api_request.dart';

import '../models/user/response_user.dart';
import '../repository/api.dart';

class ApiUsers {
  static Future<List<User>> getUsers() async {
    try {
      final response = await ApiRequest.gets(Api.users);
      if (response != null && response.isNotEmpty) {
        final List<dynamic> jsonList = response['users'];
        final data = jsonList.map((json) => User.fromJson(json)).toList();
        return data;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  static Future<User> createUser(
      User user, String password, String confPassword) async {
    try {
      FormData formData = FormData.fromMap({
        "name": user.name,
        "email": user.email,
        "password": password,
        "confPassword": confPassword,
        "role": user.role,
        "organizationId": user.organizationId,
      });
      Map? responseBody = await ApiRequest.postCreate(Api.users, formData);

      return User.fromJson(responseBody!);
    } catch (e) {
      print(e);
      throw Exception('Failed to create user: $e');
    }
  }

  static Future<int?> deleteUser(int id) async {
    try {
      Map? responseBody = await ApiRequest.delete('${Api.users}/$id');
      return responseBody!['id'];
    } catch (e) {
      print(e);
      throw Exception('Failed to delete organization: $e');
    }
  }
}
