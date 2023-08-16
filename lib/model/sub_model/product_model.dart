class ProductModel {
  List<String>? photoUrls;
  String? id;
  String? title;
  DateTime? deletedAt;

  ProductModel({
    this.photoUrls,
    this.id,
    this.title,
    this.deletedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        photoUrls: json["photo_urls"] == null
            ? []
            : List<String>.from(json["photo_urls"]!.map((x) => x)),
        id: json["_id"],
        title: json["title"],
        deletedAt: json["deleted_at"] == null
            ? null
            : DateTime.parse(json["deleted_at"]),
      );
}
