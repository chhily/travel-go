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
        await _socketService.onGetUserProfile(id: AppUrl.receiverId);
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
    await _socketService
        .onEmitMessage(chatId: chatId, pageKey: pageKey)
        .then((value) async {
      await _socketService.onReceiveChatUserToUser(
          context: context, chatId: chatId);
    });
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

  onEditSenderMessage(PersonalMessageModel? editedMessage) {
    if (editedMessage == null) return;
    _personalMessageList.firstWhere((eachMessage) {
      if (eachMessage.id == editedMessage.id) {
        final indexOfMessage = _personalMessageList.indexOf(eachMessage);
        _personalMessageList[indexOfMessage] = editedMessage;
        return true;
      }
      return false;
    });
    notifyListeners();
  }

  bool? isSeen = false;
  onUpdateSeenMessage(bool? value) => isSeen = value;

  onUpdateSendingMessage(String message) {
    _personalMessageList.insert(0, PersonalMessageModel(message: message));
    notifyListeners();
  }

  onInitTextController() {
    textMessageCT = TextEditingController();
    editTextMessageCt = TextEditingController();
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

  var editMessageWidgetController = StreamController<bool>.broadcast();

  late TextEditingController editTextMessageCt;
  bool _isEditMessage = false;
  bool get isEditMessage => _isEditMessage;

  String? _messageId;
  String? get messageId => _messageId;

  String? _textMessage;
  String? get textMessage => _textMessage;

  void onGetMessageId(
      {required String? messageId,
      required bool isEdit,
      required String? textMessage}) {
    _messageId = messageId;
    _isEditMessage = isEdit;
    _textMessage = textMessage;
    editMessageWidgetController.add(true);
  }

  Future<void> onEditTextMessage() async {
    String editedMessage = editTextMessageCt.text.trim();
    if (editedMessage.isNotEmpty) {
      try {
        await _socketService
            .onEmitEditTextMessage(
                chatId: AppUrl.chatId,
                textMessage: editedMessage,
                messageId: _messageId ?? "")
            .then((value) => onResetEdit());
      } catch (exception) {
        debugPrint("couldn't edit message $exception");
      }
    }
  }

  void onResetEdit() {
    editTextMessageCt.clear();
    onGetMessageId(messageId: null, isEdit: false, textMessage: null);
    editMessageWidgetController.add(false);
  }

  void onDispose() {
    // TODO: implement dispose
    textMessageCT.dispose();
    editTextMessageCt.dispose();
    _personalMessageList.clear();
    _personalMessageListModel = null;
    onClearPagination();
    _receiverModel = null;
  }
}
