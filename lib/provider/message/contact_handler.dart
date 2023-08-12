import 'package:flutter/material.dart';
import 'package:travel_go/constant/app_url.dart';
import 'package:travel_go/model/chat/contact_model.dart';
import 'package:collection/collection.dart';
import 'package:travel_go/model/message/personal_message.dart';

class ContactHandler with ChangeNotifier {
  final List<UserContactModel> _userContactList = [];

  List<UserContactModel> get userContactList => _userContactList;

  // final List<UserContactModel> _liveContactList = [];
  // List<UserContactModel> get liveContactList => _liveContactList;

  num _unReadCount = 0;

  num? get unReadCount => _unReadCount;

  void onGetUserContactList(List<UserContactModel>? itemList) {
    if (itemList == null) return;
    _userContactList.addAll(
      itemList.where(
        (fistValue) => _userContactList.every((secondValue) =>
            // (fistValue.unreadMessagesCount == null ||
            //     fistValue.unreadMessagesCount == 0) &&
            fistValue.id != secondValue.id),
      ),
    );
    notifyListeners();
  }

  // void onGetLiveContactList(List<UserContactModel>? itemList) {
  //   if (itemList == null) return;
  //   _liveContactList.addAll(itemList);
  //   notifyListeners();
  // }

  void onUpdateLiveContactValue(PersonalMessageModel liveValue) {
    _userContactList.firstWhereOrNull((eachValue) {
      debugPrint("${eachValue.id} ${liveValue.chatId}");
      if (eachValue.id == liveValue.chatId) {
        /**
         * ! this when we receive from existed chat
         * ! receiver (Yourself)
         * */
        if (liveValue.senderId != AppUrl.senderId) {
          final index = _userContactList.indexOf(eachValue);
          debugPrint('get index $index');
          onRemoveCurrentLiveContact(index).then((value) {
            debugPrint('after remove $index');
            onAddLiveItemToContactList(UserContactModel(
              id: eachValue.id,
              dataId: eachValue.dataId,
              lastMessage: eachValue.lastMessage,
              receiver: eachValue.receiver,
              // unreadMessagesCount: 2
            ));
            debugPrint('after add $index');
          });
        } else if (liveValue.senderId == AppUrl.senderId) {
          debugPrint(
              "same value of id ${liveValue.senderId} ${AppUrl.senderId}");
        } else {
          debugPrint("another unknown case");
        }
        return true;
      } else {
        debugPrint("diff chat ID");
        /**
         * ! this when we receive first message from another sender (other user)
         * ! receiver (Yourself)
         * */


        return false;
      }
    });
    notifyListeners();
  }

  Future<void> onRemoveCurrentLiveContact(int index) async {
    /**
     * ! it is because i use 2 dif list
     * ! to handle diff case so i need
     * ! to remove it too
     * */
    _userContactList.removeAt(index);
    // _liveContactList.removeAt(index);
  }

  void onAddLiveItemToContactList(UserContactModel? value) {
    if (value == null) return;
    // _liveContactList.insert(0, value);
    _userContactList.insert(0, value);
    notifyListeners();
  }

  onGetUnReadCount(int? value) {
    if (value == null) return;
    _unReadCount++;
    notifyListeners();
  }

  onAddUnreadMessage(List<UserContactModel>? itemList) {
    if (itemList == null) return;
    _userContactList.addAll(
      itemList.where(
        (firstElement) => itemList.every((secondElement) {
          return (firstElement.unreadMessagesCount == null ||
                  firstElement.unreadMessagesCount == 0) &&
              firstElement.id != secondElement.id;
        }),
      ),
    );
  }

  void onDispose() {
    _userContactList.clear();
    // _liveContactList.clear();
    _unReadCount = 0;
  }
}
