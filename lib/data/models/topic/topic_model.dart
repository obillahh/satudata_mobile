import 'dart:convert';

import 'response_topic.dart';

Topic topicFromJson(String str) => Topic.fromJson(json.decode(str));

String topicToJson(Topic data) => json.encode(data.toJson());

class Topic {
  List<ResponseTopic>? response;
  int? page;
  int? limit;
  int? totalRows;
  int? totalPage;

  Topic({
    this.response,
    this.page,
    this.limit,
    this.totalRows,
    this.totalPage,
  });

  Topic copyWith({
    List<ResponseTopic>? response,
    int? page,
    int? limit,
    int? totalRows,
    int? totalPage,
  }) =>
      Topic(
        response: response ?? this.response,
        page: page ?? this.page,
        limit: limit ?? this.limit,
        totalRows: totalRows ?? this.totalRows,
        totalPage: totalPage ?? this.totalPage,
      );

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
        response: json["response"] == null
            ? []
            : List<ResponseTopic>.from(
                json["response"]!.map((x) => ResponseTopic.fromJson(x))),
        page: json["page"],
        limit: json["limit"],
        totalRows: json["totalRows"],
        totalPage: json["totalPage"],
      );

  Map<String, dynamic> toJson() => {
        "response": response == null
            ? []
            : List<dynamic>.from(response!.map((x) => x.toJson())),
        "page": page,
        "limit": limit,
        "totalRows": totalRows,
        "totalPage": totalPage,
      };
}
