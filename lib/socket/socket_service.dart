import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:travel_go/base/base_dio_handler.dart';
import 'package:travel_go/constant/app_url.dart';
import 'package:travel_go/model/message/personal_message.dart';
import 'package:travel_go/model/message/seen_message.dart';
import 'package:travel_go/model/message/sender_receiver_model.dart';
import 'package:travel_go/provider/message/message_handler.dart';
import 'package:travel_go/socket/response_type.dart';
import 'package:travel_go/socket/socket_route.dart';

import '../constant/http_method.dart';
import '../model/message/receiver_model.dart';

class SocketService {
  static const String transportsMethod = "websocket";
  static late IO.Socket socket;

  //First step init socket {}

  void initSocket() {
    // manually connecting to websocket
    try {
      socket = IO.io(
        AppUrl.baseChatUrl,
        IO.OptionBuilder()
            .setTransports([transportsMethod])
            .enableForceNewConnection()
            .setAuth({'token': AppUrl.senderToken})
            .build(),
      );
      socket.connected;
      socket.onConnecting((data) => debugPrint("connecting => $data"));
      socket.onConnect((data) => debugPrint("connected success => $data"));
      socket.onConnectTimeout(
          (data) => debugPrint("connection timeout => $data"));

      socket.onConnectError((data) => debugPrint("connected fail => $data"));

      socket.onDisconnect(
          (data) => debugPrint("got disconnect from socket => $data"));

      socket.onAny((event, data) => debugPrint("any event => $event, $data"));
    } catch (e) {
      debugPrint("fail to init=>  ${e.toString()}");
    }
  }

  // sub to create receive message from socket
  void onCreateReceiveMessageEvent({required String receiverId}) {
    socket.on(SocketRoute.onReceiveChat, (jsonValue) {
      log("onGetChatCreate ${SocketRoute.onReceiveChat} $jsonValue");
      if (jsonValue[ResponseField.actionField] == ResponseField.actionCreate) {
        try {
          // handle response from socket
          // add response to model
          final receiveValue = SenderAndReceiverModel.fromJson(
              jsonValue[ResponseField.dataField]);
          prettyPrintJson(jsonValue[ResponseField.dataField],
              msg: "receiveValue");
          debugPrint("receiveValue $receiveValue");
        } catch (e) {
          debugPrint("couldn't receive res => ${e.toString()}");
        }
      }
    });
  }

  // emit to create send to socket
  void onCreateChatEvent({required String senderId}) async {
    socket.emit(SocketRoute.onCreateChat, {"users": senderId});
    log("create chat ${SocketRoute.onCreateChat}, {users: $senderId}");
  }

  Future<void> pubSendChatNew(
      {required String chatId,
      String? message,
      String? photo,
      String? voice}) async {
    if (message != null) {
      socket.emit(
          SocketRoute.pubChatNew, {"chat_id": chatId, "message": message});
      log("pubChatNews ${SocketRoute.pubChatNew}, {chat_id: $chatId, message: $message}");
    } else if (photo != null) {
      socket.emit(SocketRoute.pubChatNew, {"chat_id": chatId, "photo": photo});
      log("pubChatNew ${SocketRoute.pubChatNew}, {chat_id: $chatId, photo: $photo}");
    } else if (voice != null) {
      socket.emit(SocketRoute.pubChatNew, {"chat_id": chatId, "voice": voice});
      log("pubChatNew ${SocketRoute.pubChatNew}, {chat_id: $chatId, voice: $voice}");
    }
  }

  // emit to get user chat value ({send chat})
  Future<void> onEmitMessage(
      {required String chatId, required int pageKey}) async {
    /** event handle
     * * this event is to handle send data to socket
     * ! to send from sender(yourself) -> receiver(another user)
     */
    socket.emit(SocketRoute.pubChatById, {
      "chat_id": chatId,
      "per_page": 15,
      "page_number": pageKey,
      "order_by": "DESC",
    });
    prettyPrintJson(SocketRoute.pubChatById, msg: "emit to send message");
  }

  // on to receive chat
  Future<void> onReceiveChatUserToUser(
      {required String chatId, required BuildContext context}) async {
    final messageHandler = Provider.of<MessageHandler>(context, listen: false);
    socket.on("${SocketRoute.onGetChatById}/$chatId", (jsonValue) async {
      /** event handle
       * * this event is to handle data from socket
       * ! to get data from sender(another user) -> receiver(yourself)
       */
      await onReceiveAllMessage(handler: jsonValue, context: context)
          .then((value) => messageHandler.onInitPersonalMessageList(value));
      await onReceiveLiveMessage(jsonValue)
          .then((value) => messageHandler.onUpdateLiveMessage(value));
    });
  }

  Future<PersonalMessageListModel?> onReceiveAllMessage(
      {dynamic handler, required BuildContext context}) async {
    /**
     * ! get all data from socket (res is list)
     */
    try {
      //* receive from socket
      //TODO: should add to details list
      if (handler[ResponseField.actionField] == ResponseField.actionGet) {
        final personalReceiveMessage =
            PersonalMessageListModel.fromJson(handler[ResponseField.dataField]);
        if (personalReceiveMessage.pagination != null) {
          Provider.of<MessageHandler>(context, listen: false)
              .onGetPagination(personalReceiveMessage.pagination);
        }
        prettyPrintJson(handler[ResponseField.dataField],
            msg: "all data from socket");
        return personalReceiveMessage;
      }
    } catch (e) {
      debugPrint("couldn't receive message ${e.toString()}");
    }
    return null;
  }

  Future<PersonalMessageModel?> onReceiveLiveMessage(dynamic handler) async {
    /**
     * ! get new action from socket (live chat)
     */
    if (handler[ResponseField.actionField] == ResponseField.actionNew) {
      try {
        //* receive live value from sender
        //TODO: should add to model then details list
        final liveValue =
            PersonalMessageModel.fromJson(handler[ResponseField.dataField]);
        prettyPrintJson(handler[ResponseField.dataField], msg: "live message");
        return liveValue;
      } catch (e) {
        debugPrint("couldn't update any receive ${e.toString()}");
      }
    }
    return null;
  }

  Future<void> onSeenMessage(dynamic handler) async {
    if (handler[ResponseField.actionField] == ResponseField.actionSeen) {
      try {
        /// user json data and set to list
        final chatSeen =
            SeenMessageModel.fromJson(handler[ResponseField.dataField]);

        if (chatSeen.success != null) {
          /// update value seen chat by chat.success
          prettyPrintJson(handler[ResponseField.dataField], msg: "seen event");
          debugPrint("$chatSeen");
        }
      } catch (e) {
        debugPrint("catch exception actionSeen: ${e.toString()}");
      }
    }
  }

  static const JsonEncoder encoder = JsonEncoder.withIndent('  ');

  Future<ReceiverModel?> onGetUserProfile({required String id}) async {
    return BaseApiService().onRequest(
      path: "/portal/users/$id/about",
      customToken: AppUrl.senderToken,
      method: HttpMethod.GET,
      onSuccess: (response) {
        return ReceiverModel.fromJson(response.data['data']);
      },
    );
  }

  void prettyPrintJson(dynamic input, {String? msg}) {
    var prettyString = encoder.convert(input);
    prettyString
        .split('\n')
        .forEach((element) => debugPrint("$msg => $element"));
  }

  void onDisposeListener() {
    socket.disconnected;
    // socket.close();
    socket.clearListeners();
    socket.destroy();
    socket.dispose();
  }
}
