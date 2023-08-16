class ReceiverStoreModel {
  final String? id;
  final String? name;
  final String? photoUrl;
  final String? coverPhotoUrl;

  ReceiverStoreModel({
    this.id,
    this.name,
    this.photoUrl,
    this.coverPhotoUrl,
  });

  factory ReceiverStoreModel.fromJson(Map<String, dynamic> json) =>
      ReceiverStoreModel(
        id: json['_id'],
        name: json['name'],
        photoUrl: json['photo_url'],
        coverPhotoUrl: json['cover_photo_url'],
      );
}



