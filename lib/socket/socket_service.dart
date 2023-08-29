import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:travel_go/base/base_dio_handler.dart';
import 'package:travel_go/constant/app_url.dart';
import 'package:travel_go/model/chat/store_contact_model.dart';
import 'package:travel_go/model/chat/user_contact_model.dart';
import 'package:travel_go/model/message/personal_message.dart';
import 'package:travel_go/model/message/seen_message.dart';
import 'package:travel_go/model/message/sender_receiver_model.dart';
import 'package:travel_go/model/receiver_store.dart';
import 'package:travel_go/provider/message/contact_handler.dart';
import 'package:travel_go/provider/message/message_handler.dart';
import 'package:travel_go/provider/message/store_users_handler.dart';
import 'package:travel_go/provider/message/user_store_handler.dart';
import 'package:travel_go/socket/response_type.dart';
import 'package:travel_go/socket/socket_route.dart';

import '../constant/http_method.dart';
import '../model/receiver_model.dart';

class SocketService {
  static const String transportsMethod = "websocket";
  static late IO.Socket socket;

  //First step init socket {}
  void initSocket() {
    // Create a WebSocket connection.
    socket = IO.io(
      AppUrl.baseChatUrl,
      IO.OptionBuilder()
          .setTransports([transportsMethod])
          .enableForceNewConnection()
          .setAuth({'token': AppUrl.senderToken})
          .build(),
    );

    // Add error handling.
    socket.onError(handleSocketError);

    // Add logging.
    socket.onConnect((data) {
      debugPrint("Connected to WebSocket: ${data.toString()}");
    });

    // Listen for events.
    socket.onConnecting((data) => debugPrint("connecting => $data"));
    socket.onConnect((data) => debugPrint("connected success => $data"));
    socket
        .onConnectTimeout((data) => debugPrint("connection timeout => $data"));

    socket.onConnectError((data) => debugPrint("connected fail => $data"));

    socket.onDisconnect(
        (data) => debugPrint("got disconnect from socket => $data"));
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
  // this emit call when first interact to create
  // receive then => onReceiveChatUserToUser
  void onCreateSendMessageEvent({required String senderId}) async {
    socket.emit(SocketRoute.onCreateChat, {"users": senderId});
    log("create chat ${SocketRoute.onCreateChat}, {users: $senderId}");
  }

  //User to Users list
  Future<void> onEmitUserContactList({required int pageKey}) async {
    socket.emit(SocketRoute.pubUsersChatList,
        {"per_page": 10, "page_number": pageKey, "order_by": "DESC"});
    log("pubChatLists ${SocketRoute.pubUsersChatList}, {per_page: 10, "
        "page_number:"
        " $pageKey, order_by: DESC");
  }

  //User to Stores list
  Future<void> onEmitUserStoresContactList({required int pageKey}) async {
    socket.emit(SocketRoute.pubShopChatLists,
        {"per_page": 10, "page_number": pageKey, "order_by": "DESC"});
    log("pubChatLists ${SocketRoute.pubShopChatLists}, "
        "{per_page: 10, page_number:"
        " $pageKey, order_by: DESC");
  }

  //Store to users list
  Future<void> onEmitStoreUsersContactList({
    required int page,
    bool isFromNewestToOldest = true,
  }) async {
    socket.emit(SocketRoute.pubShopChatLists, {
      "per_page": 10,
      "page_number": page,

      /// "DESC" from newest to oldest, while "ASC" from oldest to newest
      "order_by": isFromNewestToOldest ? "DESC" : "ASC"
    });
    log("pubChatLists ${SocketRoute.pubShopChatLists}, "
        "{per_page: 10, page_number: $page, order_by: "
        "${isFromNewestToOldest ? "DESC" : "ASC"}} ");
  }

  Future<void> onGetStoreUsersContactList(
      {required BuildContext context}) async {
    final storeUsersHandler =
        Provider.of<StoreUsersHandler>(context, listen: false);
    socket.on(SocketRoute.onGetShopChatListsChange, (jsonValue) {
      if (jsonValue[ResponseField.actionField] == ResponseField.actionGet) {

      } else if (jsonValue[ResponseField.actionField] ==
          ResponseField.actionNew) {}
    });
  }

  //sub to receive user to users contact list from socket
  Future<void> onSubUserContactList({required BuildContext context}) async {
    final contactHandler =
        Provider.of<UserContactHandler>(context, listen: false);
    socket.on(
      SocketRoute.onGetUserChatListsChange,
      (jsonValue) async {
        /**
         * ! first get all contact list
         * */
        if (jsonValue[ResponseField.actionField] == ResponseField.actionGet) {
          await onGetAllUsersContact(jsonValue).then(
            (contactList) {
              if (contactList != null) {
                contactHandler.onGetUserContactList(contactList);
                contactHandler.onGetContactPagination(contactList.pagination);
              } else {
                debugPrint("this is another event of receive data");
              }
            },
          );
        }
        if (jsonValue[ResponseField.actionField] == ResponseField.actionNew) {
          await onReceiveUsersLiveContact(jsonValue).then(
            (liveContact) {
              if (liveContact != null) {
                contactHandler.onHandlerIncomingMessage(liveContact);
              }
            },
          );
        }
      },
    );
  }

  // sub to receive all user contact list
  Future<UsersContactListModel?> onGetAllUsersContact(dynamic jsonValue) async {
    debugPrint("action get");
    try {
      final contactList =
          UsersContactListModel.fromJson(jsonValue[ResponseField.dataField]);
      prettyPrintJson(jsonValue[ResponseField.dataField],
          msg: "user contact list");
      debugPrint("contact list $contactList");
      return contactList;
    } catch (e) {
      debugPrint("couldn't receiver user contact list $e");
    }
    return null;
  }

  Future<PersonalMessageModel?> onReceiveUsersLiveContact(
      dynamic jsonValue) async {
    try {
      final liveContact =
          PersonalMessageModel.fromJson(jsonValue[ResponseField.dataField]);
      prettyPrintJson(jsonValue[ResponseField.dataField],
          msg: "user live contact list");
      debugPrint("live contact list $liveContact");
      return liveContact;
    } catch (e) {
      debugPrint("couldn't receiver user live contact list $e");
    }
    return null;
  }

  Future<void> onSubUserStoresContactList(
      {required BuildContext context}) async {
    final userToStoreHandler =
        Provider.of<UserToStoreHandler>(context, listen: false);
    socket.on(SocketRoute.onGetShopChatListsChange, (jsonValue) async {
      log("onSubGetChatLists ${SocketRoute.onGetShopChatListsChange} $jsonValue");
      if (jsonValue[ResponseField.actionField] == ResponseField.actionGet) {
        await onGetAllUserStoresContact(jsonValue).then(
          (userStoresList) {
            if (userStoresList != null) {
              userToStoreHandler.onGetUserStoreContactList(userStoresList);
              userToStoreHandler
                  .onGetContactPagination(userStoresList.pagination);
            }
          },
        );
      }
      if (jsonValue[ResponseField.actionField] == ResponseField.actionNew) {
        await onReceiveUserStoresLiveContact(jsonValue)
            .then((liveUserStoresContact) {
          userToStoreHandler
              .onUpdateLiveStoresContactValue(liveUserStoresContact);
        });
      }
    });
  }

  Future<StoreUserContactListModel?> onGetAllUserStoresContact(
      dynamic jsonValue) async {
    try {
      final userStoresContact = StoreUserContactListModel.fromJson(
          jsonValue[ResponseField.dataField]);
      prettyPrintJson(jsonValue[ResponseField.dataField],
          msg: "User stores contact list");
      return userStoresContact;
    } catch (e) {
      debugPrint("couldn't receiver user stores contact list $e");
    }
    return null;
  }

  Future<PersonalMessageModel?> onReceiveUserStoresLiveContact(
      dynamic jsonValue) async {
    if (jsonValue[ResponseField.actionField] == ResponseField.actionNew) {
      try {
        final liveUserStores =
            PersonalMessageModel.fromJson(jsonValue[ResponseField.dataField]);
        return liveUserStores;
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

  Future<void> onDeleteMessage(
      {required String? messageId, required String? chatId}) async {
    socket
        .emit(SocketRoute.pubChatDelete, {"chat_id": chatId, "_id": messageId});
    log("pubDeleteChatById ${SocketRoute.pubChatDelete}, {chat_id: $chatId, _id: $messageId}}");
    socket.onError(handleSocketError);
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
      "per_page": 10,
      "page_number": pageKey,
      "order_by": "DESC",
    });
    prettyPrintJson(SocketRoute.pubChatById, msg: "emit to send message");
  }

  // on to receive chat
  Future<void> onReceiveChatUserToUser(
      {required String chatId, required BuildContext context}) async {
    final messageHandler = Provider.of<MessageProvider>(context, listen: false);
    socket.on("${SocketRoute.onGetChatById}/$chatId", (jsonValue) async {
      /** event handle
       * * this event is to handle data from socket
       * ! to get data from sender(another user) -> receiver(yourself)
       */

      if (jsonValue[ResponseField.actionField] == ResponseField.actionGet) {
        await onReceiveAllMessage(handler: jsonValue, context: context)
            .then((value) => messageHandler.onInitPersonalMessageList(value));
      }
      if (jsonValue[ResponseField.actionField] == ResponseField.actionNew) {
        await onReceiveLiveMessage(jsonValue)
            .then((value) => messageHandler.onUpdateLiveMessage(value));
      }
      if (jsonValue[ResponseField.actionField] == ResponseField.actionEdit) {
        await onUpdateEditedMessage(jsonValue)
            .then((value) => messageHandler.onEditSenderMessage(value));
      }
      await onSeenLiveMessage(jsonValue)
          .then((value) => messageHandler.onUpdateSeenMessage(value?.success))
          .whenComplete(() => messageHandler.onResetUnread);

      if (jsonValue[ResponseField.actionField] == ResponseField.actionDelete) {
        await onListenDeletedMessage(jsonValue)
            .then((value) => messageHandler.onRemoveDeletedMessage(value));
      }
    });
  }

  Future<void> onSeen(
      {required BuildContext context, required String chatId}) async {
    final messageHandler = Provider.of<MessageProvider>(context, listen: false);
    socket.on("${SocketRoute.onGetChatById}/$chatId", (jsonValue) async {
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
      final personalReceiveMessage =
          PersonalMessageListModel.fromJson(handler[ResponseField.dataField]);
      if (personalReceiveMessage.pagination != null) {
        Provider.of<MessageProvider>(context, listen: false)
            .onGetPagination(personalReceiveMessage.pagination);
      }
      prettyPrintJson(handler[ResponseField.dataField],
          msg: "all data from socket");
      return personalReceiveMessage;
    } catch (e) {
      debugPrint("couldn't receive message ${e.toString()}");
    }
    return null;
  }

  Future<PersonalMessageModel?> onReceiveLiveMessage(dynamic handler) async {
    /**
     * ! get new action from socket (live chat)
     */
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
    return null;
  }

  Future<PersonalMessageModel?> onUpdateEditedMessage(dynamic jsonValue) async {
    /**
     * ! on update message  (after sender || receiver edited message )
     */
    try {
      /// user json data and set to edit by its id
      final editedMessage =
          PersonalMessageModel.fromJson(jsonValue[ResponseField.dataField]);
      return editedMessage;
    } catch (e) {
      debugPrint("catch exception actionEdit: ${e.toString()}");
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

  Future<PersonalMessageModel?> onListenDeletedMessage(
      dynamic jsonValue) async {
    try {
      final deleteValue =
          PersonalMessageModel.fromJson(jsonValue[ResponseField.dataField]);
      return deleteValue;
    } catch (e) {
      debugPrint("couldn't update deleted message $e");
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

  Future<ReceiverStoreModel?> onGetStoreProfile({required String id}) async {
    return BaseApiService().onRequest(
      path: "/portal/shops/$id",
      customToken: AppUrl.senderToken,
      method: HttpMethod.GET,
      onSuccess: (response) {
        return ReceiverStoreModel.fromJson(response.data['data']);
      },
    );
  }

  void prettyPrintJson(dynamic input, {String? msg}) {
    var prettyString = encoder.convert(input);
    prettyString
        .split('\n')
        .forEach((element) => debugPrint("$msg => $element"));
  }

  void handleSocketError(error) {
    debugPrint("Error handling socket event: ${error.toString()}");
  }

  void onDisposeListener() {
    socket.dispose();
  }
}
