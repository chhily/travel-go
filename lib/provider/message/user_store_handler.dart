import 'package:flutter/cupertino.dart';
import 'package:travel_go/constant/message_type.dart';
import 'package:travel_go/model/chat/store_contact_model.dart';
import 'package:travel_go/model/chat/store_personal_message.dart';
import 'package:travel_go/model/message/personal_message.dart';
import 'package:travel_go/model/receiver_model.dart';
import 'package:travel_go/socket/socket_service.dart';

class UserToStoreHandler with ChangeNotifier {
  final SocketService _socketService = SocketService();
  final List<StoreUserContactModel> _userStoreContactList = [];
  List<StoreUserContactModel> get userStoreContactList => _userStoreContactList;

  StoreUserContactListModel? _contactListModel;
  StoreUserContactListModel? get contactListModel => _contactListModel;

  ReceiverModel? _receiverModel;
  ReceiverModel? get receiverModel => _receiverModel;

  String? _lastMessage;
  String? get lastMessage => _lastMessage;

  void onGetUserStoreContactList(StoreUserContactListModel? itemList) {
    if (itemList == null) return;
    _userStoreContactList.addAll(
      itemList.storeUserModel.where(
        (firstValue) => _userStoreContactList
            .every((secondValue) => firstValue.id != secondValue.id),
      ),
    );
    _contactListModel = itemList;
    notifyListeners();
  }

  String? onChangeLastMessage(PersonalMessageModel? value) {
    final messages = {
      MessageType.photoType: "You sent a photo",
      MessageType.textType: value?.message?.trim(),
      MessageType.voiceType: "Voice message",
      MessageType.invoiceType: "Purchase order has been created. Paid here.",
      MessageType.buyListingType: "Buy listing",
      MessageType.paymentType: "Purchase orders have been paid.",
      MessageType.productType: "Product"
    };
    return messages[value?.type] ?? "N/A";
  }

  void onDispose() {
    _userStoreContactList.clear();
    _contactListModel = null;
    _receiverModel = null;
    _lastMessage = null;
  }
}
