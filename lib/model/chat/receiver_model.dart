class ReceiverModel {
  String? id;
  String? firstName;
  String? lastName;
  String? photoUrl;
  bool? isOnline;

  ReceiverModel(
      {this.id, this.firstName, this.lastName, this.photoUrl, this.isOnline});

  factory ReceiverModel.fromJson(Map<String, dynamic> json) {
    return ReceiverModel(
      id: json['_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      photoUrl: json['photo_url'],
      isOnline: json['online'] ?? false,
    );
  }
}
