import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:travel_go/model/message/personal_message.dart';
import 'package:travel_go/model/message/sender_receiver_model.dart';
import 'package:travel_go/socket/response_type.dart';
import 'package:travel_go/socket/socket_route.dart';

class SocketService {
  static const String transportsMethod = "websocket";
  static late IO.Socket socket;

  //First step init socket {}

  void initSocket() {
    // manually connecting to websocket
    try {
      socket = IO.io(
        SocketRoute.baseUrl,
        IO.OptionBuilder()
            .setTransports([transportsMethod])
            .enableForceNewConnection()
            .setAuth({'token': SocketRoute.senderToken})
            .build(),
      );
      socket.connected;
      socket.onConnecting((data) => prettyPrintJson("connecting => $data"));
      socket.onConnect((data) => prettyPrintJson("connected success => $data"));
      socket.onConnectTimeout((data) => prettyPrintJson("connection timeout => $data"));

      socket.onConnectError((data) => prettyPrintJson("connected fail => $data"));

      socket.onDisconnect(
          (data) => prettyPrintJson("got disconnect from socket => $data"));

      socket.onAny((event, data) => prettyPrintJson("any event => $event, $data"));
    } catch (e) {
      debugPrint("fail to init=>  ${e.toString()}");
    }
  }

  // sub to receive from socket
  void onReceiveMessageEvent({required String receiverId}) {
    socket.on(SocketRoute.onReceiveChat, (jsonValue) {
      log("onGetChatCreate ${SocketRoute.onReceiveChat} $jsonValue");
      if (jsonValue[ResponseField.actionField] == ResponseField.actionCreate) {
        try {
          // handle response from socket
          // add response to model
          final receiveValue = SenderAndReceiverModel.fromJson(
              jsonValue[ResponseField.dataField]);
          prettyPrintJson("receiveValue => $receiveValue");
        } catch (e) {
          prettyPrintJson("couldn't receive res => ${e.toString()}");
        }
      }
    });
  }

  // emit to send to socket
  void onSendMessageEvent({required String senderId}) async {
    socket.emit(SocketRoute.onCreateChat, {"users": senderId});
    log("create chat ${SocketRoute.onCreateChat}, {users: $senderId}");
  }

  void onDisposeListener() {
    socket.offAny(
      (event, data) =>
          prettyPrintJson("dispose any action => $event ${data.toString()}"),
    );
  }

  // emit to get user chat value ({send chat})
  Future<void> onSendUserToUserChat({required String chatId}) async {
    /** event handle
     * * this event is to handle send data to socket
     * ! to send from sender(yourself) -> receiver(another user)
     */
    socket.emit(SocketRoute.pubChatById, {
      "chat_id": chatId,
      "per_page": 1000,
      "page_number": 1,
      "order_by": "DESC",
    });
    prettyPrintJson("get chat value => ${SocketRoute.pubChatById}, {_id: $chatId, per_page: 1000, page_number: 1, order_by: DEC}");
  }

  // on to receive chat
  Future<void> onReceiveChatUserToUser({required String chatId}) async {
    socket.on("${SocketRoute.onGetChatById}/$chatId", (jsonValue) {
      /** event handle
       * * this event is to handle data from socket
       * ! to get from sender(another user) -> receiver(yourself)
       */
      /**
      * ! first get all from socket
      */
      try {
        //* receive from socket
        //TODO: should add to details list
        if (jsonValue[ResponseField.actionField] == ResponseField.actionGet) {
          final personalReceiveMessage = PersonalMessageListModel.fromJson(
              jsonValue[ResponseField.dataField]);
          prettyPrintJson("personalReceiveMessage $personalReceiveMessage");
        }
      } catch (e) {
        debugPrint("couldn't receive message ${e.toString()}");
      }

      /**
       * ! second get new action from socket
       */
      if (jsonValue[ResponseField.actionField] == ResponseField.actionNew) {
        try {
          //* receive live value from sender
          //TODO: should add to model then details list
          final liveValue =
              PersonalMessageModel.fromJson(jsonValue[ResponseField.dataField]);
          prettyPrintJson("live message from sender $liveValue");
        } catch (e) {
          debugPrint("couldn't update any receive ${e.toString()}");
        }
      }
    });
  }

  static const JsonEncoder encoder = JsonEncoder.withIndent('  ');
  void prettyPrintJson(dynamic input) {
    var prettyString = encoder.convert(input);
    prettyString.split('\n').forEach((element) => debugPrint(element));
  }
}
