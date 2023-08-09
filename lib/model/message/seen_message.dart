class SeenMessageModel {
  final bool? success;
  final int? messageSeenCount;

  SeenMessageModel({
    this.success,
    this.messageSeenCount,
  });

  factory SeenMessageModel.fromJson(Map<String, dynamic> json) => SeenMessageModel(
    success: json['success'],
    messageSeenCount: json['message_seen_count'],
  );
}