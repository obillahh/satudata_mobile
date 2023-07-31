// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

ResponseLogin loginFromJson(String str) =>
    ResponseLogin.fromJson(json.decode(str));

String loginToJson(ResponseLogin data) => json.encode(data.toJson());

class ResponseLogin {
  String? accessToken;
  int? userId;
  String? role;
  String? name;
  int? organizationId;

  ResponseLogin({
    this.accessToken,
    this.userId,
    this.role,
    this.name,
    this.organizationId,
  });

  ResponseLogin copyWith({
    String? accessToken,
    int? userId,
    String? role,
    String? name,
    int? organizationId,
  }) =>
      ResponseLogin(
        accessToken: accessToken ?? this.accessToken,
        userId: userId ?? this.userId,
        role: role ?? this.role,
        name: name ?? this.name,
        organizationId: organizationId ?? this.organizationId,
      );

  factory ResponseLogin.fromJson(Map<dynamic, dynamic> json) => ResponseLogin(
        accessToken: json["accessToken"],
        userId: json["userId"],
        role: json["role"],
        name: json["name"],
        organizationId: json["organizationId"],
      );

  Map<dynamic, dynamic> toJson() => {
        "accessToken": accessToken,
        "userId": userId,
        "role": role,
        "name": name,
        "organizationId": organizationId,
      };
}
