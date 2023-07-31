class ResponseOrganization {
  int? id;
  String? name;
  String? url;
  String? contact;
  String? slug;
  String? type;

  ResponseOrganization({
    this.id,
    this.name,
    this.url,
    this.contact,
    this.slug,
    this.type,
  });

  ResponseOrganization copyWith({
    int? id,
    String? name,
    String? url,
    String? contact,
    String? slug,
    String? type,
  }) =>
      ResponseOrganization(
        id: id ?? this.id,
        name: name ?? this.name,
        url: url ?? this.url,
        contact: contact ?? this.contact,
        slug: slug ?? this.slug,
        type: type ?? this.type,
      );

  factory ResponseOrganization.fromJson(Map<dynamic, dynamic> json) =>
      ResponseOrganization(
        id: json["id"],
        name: json["name"],
        url: json["url"],
        contact: json["contact"],
        slug: json["slug"],
        type: json["type"],
      );

  Map<dynamic, dynamic> toJson() => {
        "id": id,
        "name": name,
        "url": url,
        "contact": contact,
        "slug": slug,
        "type": type,
      };
}
