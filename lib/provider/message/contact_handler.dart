import 'package:flutter/material.dart';
import 'package:travel_go/constant/app_url.dart';
import 'package:travel_go/constant/message_type.dart';
import 'package:travel_go/model/chat/user_contact_model.dart';
import 'package:collection/collection.dart';
import 'package:travel_go/model/message/personal_message.dart';
import 'package:travel_go/model/pagination.dart';
import 'package:travel_go/model/receiver_model.dart';
import 'package:travel_go/socket/socket_service.dart';

class UserContactHandler with ChangeNotifier {
  final SocketService _socketService = SocketService();

  String? _lastMessage;
  String? get lastMessage => _lastMessage;

  UsersContactListModel? _contactListModel;
  UsersContactListModel? get contactListModel => _contactListModel;

  Pagination? _contactPagination;
  Pagination? get contactPagination => _contactPagination;

  final List<UserContactModel> _userContactList = [];
  List<UserContactModel> get userContactList => _userContactList;

  // final List<UserContactModel> _liveContactList = [];
  // List<UserContactModel> get liveContactList => _liveContactList;
  ReceiverModel? _receiverModel;
  ReceiverModel? get receiverModel => _receiverModel;

  // num _unReadCount = 0;
  // num? get unReadCount => _unReadCount;

  void onGetUserContactList(UsersContactListModel? itemList) {
    if (itemList == null) return;
    _userContactList.addAll(
      itemList.userContactModel.where(
        (fistValue) => _userContactList.every((secondValue) =>
            // (fistValue.unreadMessagesCount == null ||
            //     fistValue.unreadMessagesCount == 0) &&
            fistValue.id != secondValue.id),
      ),
    );
    _contactListModel = itemList;
    notifyListeners();
  }

  // void onGetLiveContactList(List<UserContactModel>? itemList) {
  //   if (itemList == null) return;
  //   _liveContactList.addAll(itemList);
  //   notifyListeners();
  // }

  Future<void> onUpdateLiveContactValue(PersonalMessageModel? liveValue) async {
    _userContactList.firstWhereOrNull((eachValue) {
      debugPrint("${eachValue.id} ${liveValue?.chatId}");
      if (eachValue.id == liveValue?.chatId) {
        /**
         * ! this when we receive from existed chat
         * ! receiver (Yourself)
         * */
        if (liveValue?.senderId != AppUrl.senderId) {
          final index = _userContactList.indexOf(eachValue);
          debugPrint('get index $index');
          onRemoveCurrentLiveContact(index).then((value) {
            debugPrint('after remove $index');
            onAddLiveItemToContactList(UserContactModel(
              id: eachValue.id,
              dataId: eachValue.dataId,
              lastMessage: liveValue,
              unreadMessagesCount: eachValue.unreadMessagesCount != null
                  ? eachValue.unreadMessagesCount! + 1
                  : 1,
              receiver: eachValue.receiver,
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
          final index = _userContactList.indexOf(eachValue);
          onRemoveCurrentLiveContact(index).then((value) {
            onAddLiveItemToContactList(UserContactModel(
              id: eachValue.id,
              dataId: eachValue.dataId,
              lastMessage: liveValue,
              receiver: eachValue.receiver,
              // unreadMessagesCount: 2
            ));
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

  onHandlerIncomingMessage(PersonalMessageModel? incomingMessage) {
    onUpdateLiveContactValue(incomingMessage);
    // onAddNewIncomingMessage(personalMessageModel: incomingMessage);
  }

  onFindAndRemove(
      UserContactModel? currentList, PersonalMessageModel? incomingMessage) {
    debugPrint("${currentList?.id} ${incomingMessage?.id}");
    if (currentList?.id == incomingMessage?.id) {
      _userContactList.remove(currentList);
    }
  }

  Future<void> onRemoveCurrentLiveContact(int index) async {
    /**
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

  // onGetUnReadCount(int? value) {
  //   if (value == null) return;
  //   _unReadCount++;
  //   notifyListeners();
  // }
  //
  // onAddUnreadMessage(List<UserContactModel>? itemList) {
  //   if (itemList == null) return;
  //   _userContactList.addAll(
  //     itemList.where(
  //       (firstElement) => itemList.every((secondElement) {
  //         return (firstElement.unreadMessagesCount == null ||
  //                 firstElement.unreadMessagesCount == 0) &&
  //             firstElement.id != secondElement.id;
  //       }),
  //     ),
  //   );
  // }

  Future<ReceiverModel?> onGetReceiverInfo({required String receiverId}) async {
    _receiverModel = await _socketService.onGetUserProfile(id: receiverId);
    return _receiverModel;
  }

  Future<void> onAddNewIncomingMessage(
      {PersonalMessageModel? personalMessageModel}) async {
    if (personalMessageModel?.senderId != null) {
      await onGetReceiverInfo(receiverId: personalMessageModel?.senderId ?? "")
          .then(
        (receiverValue) {
          // for (var element in _userContactList) {
          //   print(element.id);
          // }
          _userContactList.firstWhereOrNull((eachValue) {
            print("id of eachValue ${eachValue.id}");

            /**
             * ! This when has new user contact you
             * ! Will on top the list
             * * if(senderId != current userId)Sender (Yourself)
             * * else if (senderId == current userId)Receiver (Yourself)
             * */
            if (eachValue.id != personalMessageModel?.chatId) {
              /**
              * ! Add another receiver to list
              */
              if (personalMessageModel?.senderId != AppUrl.senderId) {
                onAddLiveItemToContactList(
                  UserContactModel(
                      unreadMessagesCount: 1,
                      receiver: [
                        // receiver (Other)
                        ReceiverModel(
                            id: receiverValue?.id,
                            lastName: receiverValue?.lastName,
                            firstName: receiverValue?.firstName,
                            photoUrl: receiverValue?.photoUrl),
                        // Sender (Yourself)
                        ReceiverModel(
                            id: AppUrl.senderId,
                            lastName: "Lim",
                            firstName: "Chhily",
                            photoUrl: receiverValue?.photoUrl),
                      ],
                      lastMessage: personalMessageModel),
                );
              } else {
                debugPrint("Unknown case of incoming message");
              }
              return true;
            } else {
              return false;
            }
          });
          debugPrint("incoming message from ${receiverValue?.firstName}");
        },
      );
    }
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
      MessageType.textType: value?.message,
      MessageType.voiceType: "Voice message",
      MessageType.invoiceType: "Invoice",
      MessageType.buyListingType: "Buy listing",
    };
    return messages[value?.type] ?? "N/A";
  }

  void onDispose() {
    _userContactList.clear();
    _receiverModel = null;
    _contactPagination = null;
    _lastMessage = null;
    // _liveContactList.clear();
  }
}
