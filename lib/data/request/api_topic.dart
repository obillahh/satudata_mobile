import 'package:dio/dio.dart';

import '../models/topic/response_topic.dart';
import '../repository/api.dart';
import '../repository/api_request.dart';

class ApiTopic {
  static Future<List<ResponseTopic>> getTopics() async {
    try {
      final response = await ApiRequest.gets(Api.topics);
      if (response != null && response.isNotEmpty) {
        final List<dynamic> jsonList = response['response'];
        final data =
            jsonList.map((json) => ResponseTopic.fromJson(json)).toList();
        return data;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  static Future<List<ResponseTopic>> getTopicsWithToken() async {
    try {
      final response = await ApiRequest.getsToken(Api.topics);
      if (response != null && response.isNotEmpty) {
        final List<dynamic> jsonList = response['response'];
        final data =
            jsonList.map((json) => ResponseTopic.fromJson(json)).toList();
        return data;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  static Future<ResponseTopic?> createOrganization(ResponseTopic topic) async {
    try {
      FormData formData = FormData.fromMap({
        "name": topic.name,
        "file": await MultipartFile.fromFile(topic.url!),
      });
      Map? responseBody = await ApiRequest.postCreate(Api.topics, formData);
      return ResponseTopic.fromJson(responseBody!);
    } catch (e) {
      print(e);
      throw Exception('Failed to create data: $e');
    }
  }

  static Future<ResponseTopic?> editTopic(ResponseTopic topic) async {
    try {
      FormData formData = FormData.fromMap({
        "name": topic.name,
      });
      if (topic.url != null) {
        formData.files
            .add(MapEntry("file", await MultipartFile.fromFile(topic.url!)));
      }
      Map? responseBody =
          await ApiRequest.patch('${Api.topics}/${topic.id}', formData);
      return ResponseTopic.fromJson(responseBody!);
    } catch (e) {
      print(e);
      throw Exception('Failed to edit data: $e');
    }
  }

  static Future<int?> deleteTopic(int id) async {
    try {
      Map? responseBody = await ApiRequest.delete('${Api.topics}/$id');
      return responseBody!['id'];
    } catch (e) {
      print(e);
      throw Exception('Failed to delete topic: $e');
    }
  }
}
