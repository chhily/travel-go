import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:travel_go/constant/app_url.dart';
import 'package:travel_go/constant/message_type.dart';
import 'package:travel_go/model/chat/store_contact_model.dart';
import 'package:travel_go/model/message/personal_message.dart';
import 'package:travel_go/model/pagination.dart';
import 'package:travel_go/model/receiver_model.dart';

class UserToStoreHandler with ChangeNotifier {
  final List<StoreUserContactModel> _userStoreContactList = [];
  List<StoreUserContactModel> get userStoreContactList => _userStoreContactList;

  StoreUserContactListModel? _contactListModel;
  StoreUserContactListModel? get contactListModel => _contactListModel;

  Pagination? _contactPagination;
  Pagination? get contactPagination => _contactPagination;

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

  Future<void> onUpdateLiveStoresContactValue(
      PersonalMessageModel? liveValue) async {
    _userStoreContactList.firstWhereOrNull((eachValue) {
      debugPrint("${eachValue.id} ${liveValue?.chatId}");
      if (eachValue.id == liveValue?.chatId) {
        /**
         * ! this when we receive from existed chat
         * ! receiver (Yourself)
         * */
        if (liveValue?.senderId != AppUrl.senderId) {
          final index = _userStoreContactList.indexOf(eachValue);
          debugPrint('get index $index');
          onRemoveCurrentLiveStoresContact(index).then((value) {
            debugPrint('after remove $index');
            onAddLiveItemToContactList(StoreUserContactModel(
                id: eachValue.id,
                dataId: eachValue.dataId,
                lastMessage: liveValue,
                unreadMessagesCount: eachValue.unreadMessagesCount != null
                    ? eachValue.unreadMessagesCount! + 1
                    : 1,
                receiverStore: eachValue.receiverStore
                // unreadMessagesCount: 2
                ));
            debugPrint('after add $index');
          });
        } else if (liveValue?.senderId == AppUrl.senderId) {
          /**
           * ! this event happened when u message to another receiver
           * ! sender (Yourself) receiver (other users)
           * ! usually happened when you message on multiple device
           * ! Example : You logged your account on chrome..etc
           * ! and have your mobile device logged also
           * ! so we need to update on chrome and any device u logged
           * ! (in real time)
           * */
          debugPrint(
              "same value of id ${liveValue?.senderId} ${AppUrl.senderId}");
          final index = _userStoreContactList.indexOf(eachValue);
          onRemoveCurrentLiveStoresContact(index).then((value) {
            onAddLiveItemToContactList(StoreUserContactModel(
                id: eachValue.id,
                dataId: eachValue.dataId,
                lastMessage: liveValue,
                // receiver: eachValue.receiver,
                // unreadMessagesCount: 2
                receiverStore: eachValue.receiverStore));
          });
        } else {
          debugPrint("another unknown case");
        }
        return true;
      } else {
        debugPrint("diff chat ID");
        return false;
      }
    });

    notifyListeners();
  }

  Future<void> onRemoveCurrentLiveStoresContact(int index) async {
    /**
     * ! to handle diff case so i need
     * ! to remove it too
     * */
    _userStoreContactList.removeAt(index);
  }

  void onAddLiveItemToContactList(StoreUserContactModel? value) {
    if (value == null) return;
    _userStoreContactList.insert(0, value);
    notifyListeners();
  }

  onGetContactPagination(Pagination? value) {
    _contactPagination = value;
    notifyListeners();
  }

  String? onChangeLastMessage(PersonalMessageModel? value) {
    final messages = {
      MessageType.photoType: (value?.senderId == AppUrl.senderId)
          ? "You sent a photo"
          : "Send a photo",
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
    _contactPagination = null;
  }
}
