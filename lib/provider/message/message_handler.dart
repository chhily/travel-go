import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:travel_go/model/message/personal_message.dart';
import 'package:travel_go/model/message/receiver_model.dart';
import 'package:travel_go/model/pagination.dart';

import '../../socket/socket_service.dart';

class MessageHandler with ChangeNotifier {
  PagingController<int, PersonalMessageModel> messagePagedController =
      PagingController(firstPageKey: 1);
  final SocketService _socketService = SocketService();

  PersonalMessageListModel? _personalMessageListModel;
  PersonalMessageListModel? get personalMessage => _personalMessageListModel;

  List<PersonalMessageModel> _personalMessageList = [];

  List<PersonalMessageModel> get personalMessageList => _personalMessageList;

  Pagination? _messagePagination;

  Pagination? get getMessagePagination => _messagePagination;

  ReceiverModel? _receiverModel;

  ReceiverModel? get receiverInfo => _receiverModel;

  Future<ReceiverModel?> onGetReceiverInfo() async {
    _receiverModel =
        await SocketService().onGetUserProfile(id: "6139b0241eab37545f258b59");
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

  void onDispose() {
    // TODO: implement dispose
    _personalMessageList.clear();
    _receiverModel = null;
  }
}
