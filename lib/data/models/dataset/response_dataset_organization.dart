class ResponseDatasetOrganization {
    String? slug;
    String? name;

    ResponseDatasetOrganization({
        this.slug,
        this.name,
    });

    ResponseDatasetOrganization copyWith({
        String? slug,
        String? name,
    }) => 
        ResponseDatasetOrganization(
            slug: slug ?? this.slug,
            name: name ?? this.name,
        );

    factory ResponseDatasetOrganization.fromJson(Map<String, dynamic> json) => ResponseDatasetOrganization(
        slug: json["slug"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "slug": slug,
        "name": name,
    };
}