import 'package:satudata_mobile/data/models/organization/response_organization.dart';

import '../../repository/api.dart';
import '../../repository/http/http_request.dart';

class HttpOrganisasi {
  static Future<List<ResponseOrganization>> fetchOrganizations() async {
    Map? responseBody = await HttpRequest.gets(Api.organizations);
    if (responseBody == null) return [];
    if (responseBody.isNotEmpty) {
      List list = responseBody['response'];
      return list.map((json) => ResponseOrganization.fromJson(json)).toList();
    }
    throw Exception('Gagal Get Organisasi');
  }
}
