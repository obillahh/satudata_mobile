import 'package:dio/dio.dart';
import 'package:satudata_mobile/data/models/login_model.dart';
import 'package:satudata_mobile/data/repository/api_session.dart';

class ApiRequest {
  static final Dio dio = Dio();

  static Future<Map?> gets(String url) async {
    ResponseLogin token = await ApiSession.getUser();
    try {
      dio.options.headers['Authorization'] = 'Bearer ${token.accessToken}';
      final response = await dio.get(url);
      return response.data;
    } catch (e) {
      return null;
    }
  }

  static Future<Map?> getsToken(String url) async {
    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEsIm5hbWUiOiJTdXBlciBBZG1pbiIsInJvbGUiOiJST0xFX1NVUEVSQURNSU4iLCJlbWFpbCI6Im1pa2hhZWxzYW5kcm9AZ21haWwuY29tIiwib3JnYW5pemF0aW9uSWQiOjEsImlhdCI6MTY4OTUxNDY2MCwiZXhwIjoxNjkyMTA2NjYwfQ.ZTPHBcoesfhLC2fUzU5K2IRr1q08K08TttuwypfJghI";
    try {
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await dio.get(url);
      return response.data;
    } catch (e) {
      return null;
    }
  }

  static Future<Map?> postLogin(String url, Object? body) async {
    try {
      final response = await dio.post(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
        data: body,
      );
      Map responseBody = response.data;
      return responseBody;
    } catch (e) {
      return null;
    }
  }

  static Future<Map?> postCreate(String url, Object? body) async {
    ResponseLogin token = await ApiSession.getUser();
    try {
      final response = await dio.post(
        url,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'Authorization': 'Bearer ${token.accessToken}',
          },
        ),
        data: body,
      );
      Map responseBody = response.data;
      return responseBody;
    } catch (e) {
      return null;
    }
  }

  static Future<Map?> postCreateDataset(String url, Object? body) async {
    ResponseLogin token = await ApiSession.getUser();
    try {
      final response = await dio.post(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${token.accessToken}',
          },
        ),
        data: body,
      );
      Map responseBody = response.data;
      return responseBody;
    } catch (e) {
      return null;
    }
  }

  static Future<Map?> patch(String url, Object? body) async {
    ResponseLogin token = await ApiSession.getUser();
    try {
      final response = await dio.patch(
        url,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'Authorization': 'Bearer ${token.accessToken}',
          },
        ),
        data: body,
      );
      Map responseBody = response.data;
      return responseBody;
    } catch (e) {
      return null;
    }
  }

  static Future<Map?> patchEditDataset(String url, Object? body) async {
    ResponseLogin token = await ApiSession.getUser();
    try {
      final response = await dio.patch(
        url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${token.accessToken}',
          },
        ),
        data: body,
      );
      Map responseBody = response.data;
      return responseBody;
    } catch (e) {
      return null;
    }
  }

  static Future<Map?> delete(String url) async {
    ResponseLogin token = await ApiSession.getUser();
    try {
      final response = await dio.delete(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${token.accessToken}',
          },
        ),
      );
      Map responseBody = response.data;
      return responseBody;
    } catch (e) {
      print(e);
    }
    return null;
  }
}
