  // ignore_for_file: public_member_api_docs, sort_constructors_first

  class User {
    int? id;
    String? name;
    String? email;
    dynamic url;
    String? role;
    int? organizationId;

    User({
      this.id,
      this.name,
      this.email,
      this.url,
      this.role,
      this.organizationId,
    });

    User copyWith({
      int? id,
      String? name,
      String? email,
      dynamic url,
      String? role,
      int? organizationId,
    }) {
      return User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        url: url ?? this.url,
        role: role ?? this.role,
        organizationId: organizationId ?? this.organizationId,
      );
    }

    factory User.fromJson(Map<dynamic, dynamic> json) => User(
          id: json["id"],
          name: json["name"],
          email: json["email"],
          url: json["url"],
          role: json["role"],
          organizationId: json["organizationId"],
        );

    Map<dynamic, dynamic> toJson() => {
          "id": id,
          "name": name,
          "email": email,
          "url": url,
          "role": role,
          "organizationId": organizationId,
        };
  }
