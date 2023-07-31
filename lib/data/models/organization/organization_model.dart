// To parse this JSON data, do
//
//      organizations = organizationsFromJson(jsonString);

import 'dart:convert';

import 'package:satudata_mobile/data/models/organization/response_organization.dart';

Organizations organizationsFromJson(String str) =>
    Organizations.fromJson(json.decode(str));

String organizationsToJson(Organizations data) => json.encode(data.toJson());

class Organizations {
  List<ResponseOrganization>? response;
  int? page;
  int? limit;
  int? totalRows;
  int? totalPage;

  Organizations({
    this.response,
    this.page,
    this.limit,
    this.totalRows,
    this.totalPage,
  });

  Organizations copyWith({
    List<ResponseOrganization>? response,
    int? page,
    int? limit,
    int? totalRows,
    int? totalPage,
  }) =>
      Organizations(
        response: response ?? this.response,
        page: page ?? this.page,
        limit: limit ?? this.limit,
        totalRows: totalRows ?? this.totalRows,
        totalPage: totalPage ?? this.totalPage,
      );

  factory Organizations.fromJson(Map<String, dynamic> json) => Organizations(
        response: List<ResponseOrganization>.from(
          json["response"].map((x) => ResponseOrganization.fromJson(x)),
        ),
        page: json["page"],
        limit: json["limit"],
        totalRows: json["totalRows"],
        totalPage: json["totalPage"],
      );

  Map<String, dynamic> toJson() => {
        "response": List<dynamic>.from(
          response!.map(
            (x) => x.toJson(),
          ),
        ),
        "page": page,
        "limit": limit,
        "totalRows": totalRows,
        "totalPage": totalPage,
      };
}
