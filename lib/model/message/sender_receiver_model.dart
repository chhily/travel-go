class SenderAndReceiverModel {
  final String? id;
  final List<String>? users;

  SenderAndReceiverModel({
    this.id,
    this.users,
  });

  factory SenderAndReceiverModel.fromJson(Map<String, dynamic> json) =>
      SenderAndReceiverModel(
        id: json['_id'],
        users: json['users'] == null
            ? []
            : List<String>.from(json["users"].map((x) => x)),
      );
}
