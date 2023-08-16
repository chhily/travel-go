import 'package:travel_go/model/message/personal_message.dart';
import 'package:travel_go/model/pagination.dart';
import 'package:travel_go/model/receiver_model.dart';
import 'package:travel_go/model/receiver_store.dart';

class UsersContactListModel {
  List<UserContactModel> userContactModel;
  Pagination? pagination;

  UsersContactListModel({
    required this.userContactModel,
    required this.pagination,
  });

  factory UsersContactListModel.fromJson(Map<String, dynamic> json) =>
      UsersContactListModel(
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
    this.unreadMessagesCount = 0,
    this.lastMessage,
    this.shop,
  });

  final List<ReceiverModel>? receiver;
  final String? dataId;
  final String? id;
  int? unreadMessagesCount;
  final PersonalMessageModel? lastMessage;
  final List<ReceiverStoreModel>? shop;

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
        // shop: json["shop"] != null
        //     ? List<ReceiverStoreModel>.from(json["shop"].map((x) => x != null
        //         ? ReceiverStoreModel.fromJson(x)
        //         : ReceiverStoreModel()))
        //     : [],
      );
}
