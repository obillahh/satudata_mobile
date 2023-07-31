import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:satudata_mobile/data/models/dataset/response_dataset.dart';
import 'package:satudata_mobile/data/repository/api.dart';
import 'package:satudata_mobile/data/repository/api_request.dart';

class ApiDatasets {
  static Future<List<ResponseDataset>> getDatasets() async {
    try {
      final response = await ApiRequest.gets(Api.dataset);
      final List<dynamic> jsonList = response!['response'];
      final data = jsonList.map((e) => ResponseDataset.fromJson(e)).toList();
      return data;
    } catch (e) {
      print(e);
      throw Exception('Failed to fetch dataset: $e');
    }
  }

  static Future<List<ResponseDataset>> getDatasetsWithToken() async {
    try {
      final response = await ApiRequest.getsToken(Api.dataset);
      final List<dynamic> jsonList = response!['response'];

      final data = jsonList.map((e) => ResponseDataset.fromJson(e)).toList();

      final List<ResponseDataset> datasetResponse = List<ResponseDataset>.from(
          response["response"]!.map((x) => ResponseDataset.fromJson(x)));
      inspect(datasetResponse);
      return data;
    } catch (e) {
      print(e);
      throw Exception('Failed to fetch dataset: $e');
    }
  }

  static Future<ResponseDataset?> createDataset(ResponseDataset dataset) async {
    try {
      FormData formData = FormData.fromMap({
        "title": dataset.title,
        "organizazationId": dataset.organization,
      });
      Map? responseBody =
          await ApiRequest.postCreateDataset(Api.dataset, formData);
      return ResponseDataset.fromJson(responseBody!);
    } catch (e) {
      print(e);
      throw Exception('Failed to create dataset: $e');
    }
  }

  static Future<ResponseDataset?> editDataset(ResponseDataset dataset) async {
    try {
      FormData formData = FormData.fromMap({
        "title": dataset.title,
        "organizazationId": dataset.organization,
      });
      Map? responseBody =
          await ApiRequest.patchEditDataset(Api.dataset, formData);
      return ResponseDataset.fromJson(responseBody!);
    } catch (e) {
      print(e);
      throw Exception('Failed to create dataset: $e');
    }
  }
}
