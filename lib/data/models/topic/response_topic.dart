class ResponseTopic {
    String? name;
    int? id;
    String? url;
    String? slug;

    ResponseTopic({
        this.name,
        this.id,
        this.url,
        this.slug,
    });

    ResponseTopic copyWith({
        String? name,
        int? id,
        String? url,
        String? slug,
    }) => 
        ResponseTopic(
            name: name ?? this.name,
            id: id ?? this.id,
            url: url ?? this.url,
            slug: slug ?? this.slug,
        );

    factory ResponseTopic.fromJson(Map<dynamic, dynamic> json) => ResponseTopic(
        name: json["name"],
        id: json["id"],
        url: json["url"],
        slug: json["slug"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "url": url,
        "slug": slug,
    };
}