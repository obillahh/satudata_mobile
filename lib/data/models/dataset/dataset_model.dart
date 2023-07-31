import 'dart:convert';

import 'package:satudata_mobile/data/models/dataset/response_dataset.dart';

Dataset datasetFromJson(String str) => Dataset.fromJson(json.decode(str));

String datasetToJson(Dataset data) => json.encode(data.toJson());

class Dataset {
  List<ResponseDataset>? response;
  int? page;
  int? limit;
  int? totalRows;
  int? totalPage;

  Dataset({
    this.response,
    this.page,
    this.limit,
    this.totalRows,
    this.totalPage,
  });

  Dataset copyWith({
    List<ResponseDataset>? response,
    int? page,
    int? limit,
    int? totalRows,
    int? totalPage,
  }) =>
      Dataset(
        response: response ?? this.response,
        page: page ?? this.page,
        limit: limit ?? this.limit,
        totalRows: totalRows ?? this.totalRows,
        totalPage: totalPage ?? this.totalPage,
      );

  factory Dataset.fromJson(Map<String, dynamic> json) => Dataset(
        response: json["response"] == null
            ? []
            : List<ResponseDataset>.from(
                json["response"]!.map((x) => ResponseDataset.fromJson(x))),
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
