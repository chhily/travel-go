class ReceiverModel {
  String? id;
  String? firstName;
  String? lastName;
  String? photoUrl;
  bool? isOnline;
  bool? isSubscribe;

  ReceiverModel(
      {this.id,
      this.firstName,
      this.lastName,
      this.photoUrl,
      this.isOnline,
      this.isSubscribe});

  factory ReceiverModel.fromJson(Map<String, dynamic> json) {
    return ReceiverModel(
      id: json['_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      photoUrl: json['photo_url'],
      isOnline: json['online'] ?? false,
      // isSubscribe:
      //     (json['is_subscribed'] == null || json['is_followed'] == null)
      //         ? false
      //         : json['is_subscribed'] ?? json['is_followed']
      isSubscribe: json['is_subscribed'] ?? json['is_followed'] ?? false,
    );
  }
}
