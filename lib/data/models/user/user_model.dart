import 'dart:convert';

import 'package:satudata_mobile/data/models/user/response_user.dart';


Login usersFromJson(String str) => Login.fromJson(json.decode(str));

String usersToJson(Login data) => json.encode(data.toJson());

class Login {
  List<User>? users;
  int? page;
  int? limit;
  int? totalRows;
  int? totalPage;

  Login({
    this.users,
    this.page,
    this.limit,
    this.totalRows,
    this.totalPage,
  });

  Login copyWith({
    List<User>? users,
    int? page,
    int? limit,
    int? totalRows,
    int? totalPage,
  }) =>
      Login(
        users: users ?? this.users,
        page: page ?? this.page,
        limit: limit ?? this.limit,
        totalRows: totalRows ?? this.totalRows,
        totalPage: totalPage ?? this.totalPage,
      );

  factory Login.fromJson(Map<dynamic, dynamic> json) => Login(
        users: json["users"] == null
            ? []
            : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
        page: json["page"],
        limit: json["limit"],
        totalRows: json["totalRows"],
        totalPage: json["totalPage"],
      );

  Map<dynamic, dynamic> toJson() => {
        "users": users == null
            ? []
            : List<dynamic>.from(users!.map((x) => x.toJson())),
        "page": page,
        "limit": limit,
        "totalRows": totalRows,
        "totalPage": totalPage,
      };
}
