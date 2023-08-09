import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_go/model/message/personal_message.dart';
import 'package:travel_go/model/message/receiver_model.dart';

import '../../socket/socket_service.dart';

class MessageHandler with ChangeNotifier {
  List<PersonalMessageModel> _personalMessageList = [];

  List<PersonalMessageModel> get personalMessageList => _personalMessageList;

  static MessageHandler getMessageHandler(BuildContext context,
          [bool listen = false]) =>
      Provider.of<MessageHandler>(context, listen: listen);

  ReceiverModel? _receiverModel;

  ReceiverModel? get receiverInfo => _receiverModel;

  Future<ReceiverModel?> onGetReceiverInfo() async {
    _receiverModel =
        await SocketService().onGetUserProfile(id: "6139b0241eab37545f258b59");
    return _receiverModel;
  }

  onInitPersonalMessageList(List<PersonalMessageModel>? value) {
    if (value == null) return;
    _personalMessageList = value;
    notifyListeners();
  }

  onUpdateLiveMessage(PersonalMessageModel? liveValue) {
    if (liveValue == null) return;
    _personalMessageList.insert(0, liveValue);
    notifyListeners();
  }

  void onDispose() {
    // TODO: implement dispose
    _personalMessageList.clear();
    _receiverModel = null;
  }
}
