import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:travel_go/base/base_dio_handler.dart';
import 'package:travel_go/constant/app_url.dart';
import 'package:travel_go/model/chat/contact_model.dart';
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
    socket.once(SocketRoute.onReceiveChat, (jsonValue) {
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
  // this emit call when first interact to create
  // receive then => onReceiveChatUserToUser
  void onCreateSendMessageEvent({required String senderId}) async {
    socket.emit(SocketRoute.onCreateChat, {"users": senderId});
    log("create chat ${SocketRoute.onCreateChat}, {users: $senderId}");
  }

  //User to User list
  Future<void> onEmitUserContactList({required int pageKey}) async {
    socket.emit(SocketRoute.pubUsersChatList,
        {"per_page": 10, "page_number": pageKey, "order_by": "DESC"});
    log("pubChatLists ${SocketRoute.pubUsersChatList}, {per_page: 10, page_number: $pageKey, order_by: DESC");
  }

  //sub to receive contact list from socket
  Future<void> onSubUserContactList() async {
    socket.on(SocketRoute.onGetUserChatListsChange, (jsonValue) async {
      /**
       * ! first get all contact list
       * */
      await onGetAllUserContact(jsonValue).then((value) => null);
    });
  }

  Future<ContactListModel?> onGetAllUserContact(dynamic jsonValue) async {
    if (jsonValue[ResponseField.actionField] == ResponseField.actionGet) {
      try {
        final contactList =
            ContactListModel.fromJson(jsonValue[ResponseField.dataField]);
        prettyPrintJson(jsonValue[ResponseField.dataField],
            msg: "user contact list");
        debugPrint("contact list $contactList");
      } catch (e) {
        debugPrint("couldn't receiver user contact list $e");
      }
    }
    return null;
  }

  Future<UserContactModel?> onReceiveLiveContact(dynamic jsonValue) async {
    if (jsonValue[ResponseField.actionField] == ResponseField.actionNew) {
      try {
        final inComingMessage = PersonalMessageModel.fromJson(jsonValue[ResponseField.dataField]);


      } catch (e) {
        debugPrint("Couldn't receive live contact $e");
      }
    }
    return null;
  }

  // send edited message
  Future<void> onEmitEditTextMessage(
      {required String chatId,
      required String messageId,
      required String textMessage}) async {
    socket.emit(SocketRoute.pubChatEdit,
        {"chat_id": chatId, "message_id": messageId, "message": textMessage});
    log("pubEditChatById ${SocketRoute.pubChatEdit}, {chat_id: $chatId, message_id: $messageId, message: $textMessage}");
  }

  // send new message
  Future<void> onEmitToSendNewMessage(
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
      await onUpdateEditedMessage(jsonValue)
          .then((value) => messageHandler.onEditSenderMessage(value));
      await onSeenLiveMessage(jsonValue)
          .then((value) => messageHandler.onUpdateSeenMessage(value?.success));
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

  Future<PersonalMessageModel?> onUpdateEditedMessage(dynamic jsonValue) async {
    /**
     * ! on update message  (after sender || receiver edited message )
     */
    if (jsonValue[ResponseField.actionField] == ResponseField.actionEdit) {
      try {
        /// user json data and set to edit by its id
        final editedMessage =
            PersonalMessageModel.fromJson(jsonValue[ResponseField.dataField]);
        return editedMessage;
      } catch (e) {
        debugPrint("catch exception actionEdit: ${e.toString()}");
      }
    }
    return null;
  }

  Future<SeenMessageModel?> onSeenLiveMessage(dynamic handler) async {
    /**
     * ! on seen (live & and first init)
     */
    if (handler[ResponseField.actionField] == ResponseField.actionSeen) {
      try {
        /// user json data and set to list
        final chatSeen =
            SeenMessageModel.fromJson(handler[ResponseField.dataField]);
        if (chatSeen.success != null) {
          /// update value seen chat by chat.success
          prettyPrintJson(handler[ResponseField.dataField], msg: "seen event");
          return chatSeen;
        }
      } catch (e) {
        debugPrint("catch exception actionSeen: ${e.toString()}");
      }
    }
    return null;
  }

  Future<void> onEmitToSeenAllMessage({required String chatId}) async {
    socket.emit(SocketRoute.pubChatSeen, {"chat_id": chatId});
    log("seen all message ${SocketRoute.pubChatSeen}, {chat_id: $chatId}");
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
    socket.close();
    socket.clearListeners();
    socket.destroy();
    socket.dispose();
  }
}
