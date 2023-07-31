import 'package:satudata_mobile/data/models/dataset/response_dataset_organization.dart';

class ResponseDataset {
  int? id;
  String? title;
  DateTime? updatedAt;
  bool? isPublish;
  ResponseDatasetOrganization? organization;

  ResponseDataset({
    this.id,
    this.title,
    this.updatedAt,
    this.isPublish,
    this.organization,
  });

  ResponseDataset copyWith({
    int? id,
    String? title,
    DateTime? updatedAt,
    bool? isPublish,
    ResponseDatasetOrganization? organization,
  }) =>
      ResponseDataset(
        id: id ?? this.id,
        title: title ?? this.title,
        updatedAt: updatedAt ?? this.updatedAt,
        isPublish: isPublish ?? this.isPublish,
        organization: organization ?? this.organization,
      );

  factory ResponseDataset.fromJson(Map<dynamic, dynamic> json) =>
      ResponseDataset(
        id: json["id"],
        title: json["title"],
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        isPublish: json["isPublish"],
        organization: json["Organization"] == null
            ? null
            : ResponseDatasetOrganization.fromJson(json["Organization"]),
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "title": title,
        "updatedAt": updatedAt?.toIso8601String(),
        "isPublish": isPublish,
        "Organization": organization?.toJson(),
      };
}
