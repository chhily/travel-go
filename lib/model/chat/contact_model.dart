import 'package:travel_go/model/chat/receiver_model.dart';
import 'package:travel_go/model/message/personal_message.dart';
import 'package:travel_go/model/pagination.dart';

class ContactListModel {
  List<UserContactModel> userContactModel;
  Pagination? pagination;

  ContactListModel({
    required this.userContactModel,
    required this.pagination,
  });

  factory ContactListModel.fromJson(Map<String, dynamic> json) =>
      ContactListModel(
        userContactModel: json["data"] == null
            ? []
            : List<UserContactModel>.from(
                json["data"].map((x) => UserContactModel.fromJson(x))),
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
      );
}

class UserContactModel {
  UserContactModel({
    this.id,
    this.receiver,
    this.dataId,
    this.unreadMessagesCount,
    this.lastMessage,
    this.shop,
  });

  final List<ReceiverModel>? receiver;
  final String? dataId;
  final String? id;
  final int? unreadMessagesCount;
  final PersonalMessageModel? lastMessage;
  final dynamic shop;

  factory UserContactModel.fromJson(Map<String, dynamic> json) =>
      UserContactModel(
        id: json["_id"],
        receiver: json["users"] == null
            ? []
            : List<ReceiverModel>.from(json["users"].map((x) =>
                x != null ? ReceiverModel.fromJson(x) : ReceiverModel())),
        dataId: json['id'],
        unreadMessagesCount: json['unread_messages_count'],
        lastMessage: json["last_message"] == null
            ? null
            : PersonalMessageModel.fromJson(json["last_message"]),
      );
}
