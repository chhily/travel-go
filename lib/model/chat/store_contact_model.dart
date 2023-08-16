import 'package:travel_go/model/message/personal_message.dart';
import 'package:travel_go/model/pagination.dart';
import 'package:travel_go/model/receiver_model.dart';
import 'package:travel_go/model/receiver_store.dart';

class StoreUserContactListModel {
  final List<StoreUserContactModel> storeUserModel;
  final Pagination? pagination;

  StoreUserContactListModel({
    required this.storeUserModel,
    required this.pagination,
  });

  factory StoreUserContactListModel.fromJson(Map<String, dynamic> json) =>
      StoreUserContactListModel(
        storeUserModel: json["data"] == null
            ? []
            : List<StoreUserContactModel>.from(
                json["data"]!.map((x) => StoreUserContactModel.fromJson(x))),
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
      );
}

class StoreUserContactModel {
  List<ReceiverModel>? receiver;
  String? id;
  ReceiverStoreModel? receiverStore;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? dataId;
  int? unreadMessagesCount;
  PersonalMessageModel? lastMessage;

  StoreUserContactModel({
    this.receiver,
    this.id,
    this.receiverStore,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.dataId,
    this.unreadMessagesCount,
    this.lastMessage,
  });

  factory StoreUserContactModel.fromJson(Map<String, dynamic> json) =>
      StoreUserContactModel(
        receiver: json["users"] == null
            ? []
            : List<ReceiverModel>.from(
                json["users"]!.map((x) => ReceiverModel.fromJson(x))),
        id: json["_id"],
        receiverStore: json["shop"] == null
            ? null
            : ReceiverStoreModel.fromJson(json["shop"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        v: json["__v"],
        dataId: json["id"],
        unreadMessagesCount: json["unread_messages_count"],
        lastMessage: json["last_message"] == null
            ? null
            : PersonalMessageModel.fromJson(json["last_message"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "__v": v,
        "id": dataId,
        "unread_messages_count": unreadMessagesCount,
      };
}
