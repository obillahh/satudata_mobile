import 'package:dio/dio.dart';
import 'package:satudata_mobile/data/models/organization/response_organization.dart';
import 'package:satudata_mobile/data/repository/api.dart';
import 'package:satudata_mobile/data/repository/api_request.dart';

class ApiOrganization {
  static Future<List<ResponseOrganization>> getOrganization() async {
    try {
      final response = await ApiRequest.gets(Api.organizations);
      final List<dynamic> jsonList = response!['response'];
      final data =
          jsonList.map((json) => ResponseOrganization.fromJson(json)).toList();
      return data;
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  static Future<List<ResponseOrganization>> getOrganizationWithToken() async {
    try {
      final response = await ApiRequest.getsToken(Api.organizations);
      final List<dynamic> jsonList = response!['response'];
      final data =
          jsonList.map((json) => ResponseOrganization.fromJson(json)).toList();
      return data;
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  static Future<ResponseOrganization?> createOrganization(
      ResponseOrganization organization) async {
    try {
      FormData formData = FormData.fromMap({
        "name": organization.name,
        "file": await MultipartFile.fromFile(organization.url!),
        "contact": organization.contact,
        "type": organization.type,
      });
      Map? responseBody =
          await ApiRequest.postCreate(Api.organizations, formData);
      return ResponseOrganization.fromJson(responseBody!);
    } catch (e) {
      print(e);
      throw Exception('Failed to create data: $e');
    }
  }

  static Future<ResponseOrganization?> editOrganizations(
      ResponseOrganization organization) async {
    try {
      FormData formData = FormData.fromMap({
        "name": organization.name,
        "contact": organization.contact,
        "type": organization.type,
      });
      if (organization.url != null) {
        formData.files.add(
            MapEntry("file", await MultipartFile.fromFile(organization.url!)));
      }
      Map? responseBody = await ApiRequest.patch(
          '${Api.organizations}/${organization.id}', formData);
      return ResponseOrganization.fromJson(responseBody!);
    } catch (e) {
      print(e);
      throw Exception('Failed to edit data: $e');
    }
  }

  static Future<int?> deleteOrganization(int id) async {
    try {
      Map? responseBody = await ApiRequest.delete('${Api.organizations}/$id');
      return responseBody!['id'];
    } catch (e) {
      print(e);
      throw Exception('Failed to delete organization: $e');
    }
  }
}
