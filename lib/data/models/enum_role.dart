// ignore: constant_identifier_names
enum Role {
  ROLE_SUPERADMIN,
  ROLE_ADMIN,
  ROLE_USER,
}

final roleValues = EnumValues(
  {
    "ROLE_SUPERADMIN": Role.ROLE_SUPERADMIN,
    "ROLE_ADMIN": Role.ROLE_ADMIN,
    "ROLE_USER": Role.ROLE_USER,
  },
);

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
