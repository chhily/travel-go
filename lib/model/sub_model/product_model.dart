class ProductModel {
  List<String>? photoUrls;
  String? id;
  String? title;

  ProductModel({
    this.photoUrls,
    this.id,
    this.title,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        photoUrls: json["photo_urls"] == null
            ? []
            : List<String>.from(json["photo_urls"]!.map((x) => x != null)),
        id: json["_id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "photo_urls": photoUrls == null
            ? []
            : List<dynamic>.from(photoUrls!.map((x) => x)),
        "_id": id,
        "title": title,
      };
}
