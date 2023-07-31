import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpRequest {
  static Future<Map?> gets(String url) async {
    String token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjEsIm5hbWUiOiJTdXBlciBBZG1pbiIsInJvbGUiOiJST0xFX1NVUEVSQURNSU4iLCJlbWFpbCI6Im1pa2hhZWxzYW5kcm9AZ21haWwuY29tIiwib3JnYW5pemF0aW9uSWQiOjEsImlhdCI6MTY4NzI3ODAyMywiZXhwIjoxNjg5ODcwMDIzfQ.cU2gaC03wmQBsRRQPFRgK8mYgTBsTtOrXgGEY1mZBTc';
    try {
      var headers = {
            'Content-Type': 'application.json',
            'Authorization': 'Bearer $token'
          },
          response = await http.get(Uri.parse(url), headers: headers);
      Map responseBody = jsonDecode(response.body);
      return responseBody;
    } catch (e) {
      return null;
    }
  }

  static Future<Map?> post(String url, Object? body) async {
    try {
      var response = await http.post(Uri.parse(url),
          headers: {'Content-Type': 'application/json'}, body: body);
      Map responseBody = jsonDecode(response.body);
      return responseBody;
    } catch (e) {
      return null;
    }
  }
}
