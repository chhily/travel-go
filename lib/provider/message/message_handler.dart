import 'dart:async';

import 'package:flutter/material.dart';
import 'package:travel_go/model/message/personal_message.dart';
import 'package:travel_go/model/message/receiver_model.dart';
import 'package:travel_go/model/pagination.dart';

import '../../constant/app_url.dart';
import '../../socket/socket_service.dart';

class MessageHandler with ChangeNotifier {
  final SocketService _socketService = SocketService();
  late TextEditingController textMessageCT;

  PersonalMessageListModel? _personalMessageListModel;
  PersonalMessageListModel? get personalMessage => _personalMessageListModel;

  final List<PersonalMessageModel> _personalMessageList = [];

  List<PersonalMessageModel> get personalMessageList => _personalMessageList;

  Pagination? _messagePagination;
  Pagination? get getMessagePagination => _messagePagination;

  ReceiverModel? _receiverModel;
  ReceiverModel? get receiverInfo => _receiverModel;

  Future<ReceiverModel?> onGetReceiverInfo() async {
    _receiverModel =
        await _socketService.onGetUserProfile(id: "6139b0241eab37545f258b59");
    return _receiverModel;
  }

  bool loading = false;

  onChangeLoading(bool value) => loading = value;

  onGetPagination(Pagination? value) {
    _messagePagination = value;
    notifyListeners();
  }

  onClearPagination() {
    _messagePagination = null;
  }

  Future<void> onGetChatByID(
      {required String chatId,
      required int pageKey,
      required BuildContext context}) async {
    onChangeLoading(true);
    await _socketService
        .onEmitMessage(chatId: chatId, pageKey: pageKey)
        .then((value) async {
      await _socketService.onReceiveChatUserToUser(
          context: context, chatId: chatId);
    });
    onChangeLoading(false);
  }

  onInitPersonalMessageList(PersonalMessageListModel? value) {
    if (value == null) return;
    _personalMessageList.addAll(
      value.personalMessage.where(
        (firstValue) => _personalMessageList
            .every((secondValue) => firstValue.id != secondValue.id),
      ),
    );
    _personalMessageListModel = value;
    notifyListeners();
  }

  onUpdateLiveMessage(PersonalMessageModel? liveValue) {
    if (liveValue == null) return;
    _personalMessageList.insert(0, liveValue);
    notifyListeners();
  }

  onUpdateSendingMessage(String message) {
    _personalMessageList.insert(0, PersonalMessageModel(message: message));
    notifyListeners();
  }

  onInitTextController() {
    textMessageCT = TextEditingController();
  }

  var sentMessageController = StreamController<String?>.broadcast();

  Future<void> onSendTextMessage() async {
    String textMessage = textMessageCT.text.trim();
    if (textMessage.isNotEmpty) {
      try {
        await _socketService
            .pubSendChatNew(chatId: AppUrl.chatId, message: textMessage)
            .then((value) {
          textMessageCT.clear();
        });
      } catch (exception) {
        debugPrint("error create new message $exception");
      }
    }
  }

  Future<void> onEditTextMessage() async {}

  void onDispose() {
    // TODO: implement dispose
    _personalMessageList.clear();
    _personalMessageListModel = null;
    textMessageCT.dispose();
    // sentMessageController.close();
    onClearPagination();
    _receiverModel = null;
  }
}
