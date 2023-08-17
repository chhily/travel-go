import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:travel_go/constant/message_type.dart';
import 'package:travel_go/model/message/personal_message.dart';
import 'package:travel_go/model/receiver_model.dart';
import 'package:travel_go/model/pagination.dart';
import 'package:travel_go/model/receiver_store.dart';

import '../../socket/socket_service.dart';
import 'package:image_picker/image_picker.dart';

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);

class MessageHandler with ChangeNotifier {
  final SocketService _socketService = SocketService();

  late TextEditingController textMessageCT;
  late TextEditingController editTextMessageCt;

  var editMessageWidgetController = StreamController<bool>.broadcast();

  var imagePreviewWidgetController = StreamController<bool>.broadcast();

  bool _isEditMessage = false;
  bool get isEditMessage => _isEditMessage;

  String? _messageId;
  String? get messageId => _messageId;

  String? _textMessage;
  String? get textMessage => _textMessage;

  PersonalMessageListModel? _personalMessageListModel;
  PersonalMessageListModel? get personalMessage => _personalMessageListModel;

  final List<PersonalMessageModel> _personalMessageList = [];

  List<PersonalMessageModel> get personalMessageList => _personalMessageList;

  Pagination? _messagePagination;
  Pagination? get getMessagePagination => _messagePagination;

  ReceiverModel? _receiverModel;
  ReceiverModel? get receiverInfo => _receiverModel;
  ReceiverStoreModel? _receiverStoreModel;
  ReceiverStoreModel? get receiverStoreInfo => _receiverStoreModel;

  XFile? _imageFile;
  XFile? get imageFile => _imageFile;

  String? _imageExtension;
  String? get imageExtension => _imageExtension;

  Uint8List? _decodedImage;
  Uint8List? get decodedImage => _decodedImage;

  String? _base64Image;
  String? get base64Image => _base64Image;

  String? _sendMessageType;
  String? get sendMessageType => _sendMessageType;

  String? _imageValue;
  String? get imageValue => _imageValue;

  onInitTextController() {
    textMessageCT = TextEditingController();
    editTextMessageCt = TextEditingController();
  }

  onChangeSendMessageType(String? value) {
    _sendMessageType = value;
    notifyListeners();
  }

  Future<ReceiverModel?> onGetReceiverInfo({required String receiverId}) async {
    _receiverModel = await _socketService.onGetUserProfile(id: receiverId);
    return _receiverModel;
  }

  Future<ReceiverStoreModel?> onGetStoreReceiverInfo(
      {required String receiverId}) async {
    _receiverStoreModel =
        await _socketService.onGetStoreProfile(id: receiverId);
    return _receiverStoreModel;
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

  Future<XFile?> onOpenImageGallery() async {
    _imageFile = await ImagePicker()
        .pickImage(source: ImageSource.gallery)
        .then((value) {
      onChangeSendMessageType(SendMessageType.imageMessage);
      imagePreviewWidgetController.add(true);
      return value;
    });
    return _imageFile;
  }

  Future<Uint8List?> onDecodeImage(XFile? file) async {
    return _decodedImage = await file?.readAsBytes();
  }

  Future<void> imageConvertor({XFile? file}) async {
    await onDecodeImage(file)
        .then((value) => _base64Image = base64.encode(value ?? []));
    _imageExtension = file?.path.split(".").last;
  }

  void onGetValuePasser({String? imageExtension, String? base64Image}) {
    _imageValue = "data:image/$imageExtension;base64,$base64Image";
  }

  Future<void> onSendTextMessage({required String chatId}) async {
    String textMessage = textMessageCT.text.trim();
    if (textMessage.isNotEmpty) {
      try {
        await _socketService
            .onEmitToSendNewMessage(chatId: chatId, message: textMessage)
            .then((value) {
          textMessageCT.clear();
        });
      } catch (exception) {
        debugPrint("error create new message $exception");
      }
    }
  }

  Future<void> onSendImageMessage(
      {String? photoBase64, required String chatId}) async {
    try {
      await _socketService.onEmitToSendNewMessage(
          chatId: chatId, photo: photoBase64);
    } catch (exception) {
      debugPrint("couldn't send image $exception");
    }
  }

  void onGetMessageId(
      {required String? messageId,
      required bool isEdit,
      required String? textMessage}) {
    _messageId = messageId;
    _isEditMessage = isEdit;
    _textMessage = textMessage;
    editMessageWidgetController.add(true);
  }

  Future<void> onEditTextMessage({required String chatId}) async {
    String editedMessage = editTextMessageCt.text.trim();
    if (editedMessage.isNotEmpty) {
      try {
        await _socketService
            .onEmitEditTextMessage(
                chatId: chatId,
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

  void onResetImageValue() {
    _imageFile = null;
    _imageExtension = null;
    _base64Image = null;
    _imageValue = null;
    onChangeSendMessageType(null);
    imagePreviewWidgetController.add(false);
    _decodedImage = null;
  }

  void onDispose() {
    // TODO: implement dispose
    textMessageCT.dispose();
    editTextMessageCt.dispose();
    _personalMessageList.clear();
    _personalMessageListModel = null;
    _sendMessageType = null;
    onClearPagination();
    _receiverModel = null;
    _receiverStoreModel = null;
  }
}
