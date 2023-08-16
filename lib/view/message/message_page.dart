import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_go/constant/app_color.dart';
import 'package:travel_go/model/receiver_model.dart';
import 'package:travel_go/model/receiver_store.dart';
import 'package:travel_go/provider/message/message_handler.dart';
import 'package:travel_go/socket/socket_service.dart';
import 'package:travel_go/util/extension.dart';
import 'package:travel_go/view/message/message_list.dart';
import 'package:travel_go/view/message/utility/sender_action.dart';
import 'package:travel_go/view/message/widget/message_appbar.dart';
import 'package:travel_go/widget/loading_helper.dart';

class MessagePage extends StatefulWidget {
  final String chatId;
  final String receiverId;
  final bool isUserStore;
  const MessagePage(
      {super.key,
      required this.chatId,
      required this.receiverId,
      required this.isUserStore});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  late MessageHandler messageHandler;
  late SocketService socketService;
  int pageKey = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    messageHandler = Provider.of<MessageHandler>(context, listen: false);
    onInitSocket();
    messageHandler.onInitTextController();
  }

  Future<ReceiverModel?> onGetUserReceiver() async {
    final data =
        await messageHandler.onGetReceiverInfo(receiverId: widget.receiverId);
    return data;
  }

  Future<ReceiverStoreModel?> onGetStoreReceiver() async {
    final data = await messageHandler.onGetStoreReceiverInfo(
        receiverId: widget.receiverId);
    return data;
  }

  onInitSocket() {
    Provider.of<MessageHandler>(context, listen: false);
    socketService = SocketService();
    socketService.initSocket();
    socketService.onEmitToSeenAllMessage(chatId: widget.chatId);
    messageHandler.onGetChatByID(
        chatId: widget.chatId, context: context, pageKey: pageKey);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    messageHandler.onDispose();
    socketService.onDisposeListener();
    // messageHandler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.isUserStore ? onGetStoreReceiver() : onGetUserReceiver(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const LoadingHelper();
        } else {
          return GestureDetector(
            onTap: () {
              socketService.onSeen(chatId: widget.chatId, context: context);
              TravelGoExtension(context).hideKeyboard();
            },
            child: Scaffold(
                backgroundColor: AppColors.white,
                appBar: MessageAppBar(
                  receiverStoreInfo: messageHandler.receiverStoreInfo,
                  receiverUserInfo: messageHandler.receiverInfo,
                ),
                body: Column(
                  children: [
                    Expanded(child: MessageListWidget(
                      dataLoader: () async {
                        if (messageHandler.personalMessageList.length >= 10) {
                          pageKey += 1;
                          messageHandler.getMessagePagination != null &&
                              pageKey <=
                                  (messageHandler.personalMessage!.pagination!
                                              .total /
                                          10)
                                      .ceil();
                          await socketService.onEmitMessage(
                              chatId: widget.chatId, pageKey: pageKey);
                        }
                      },
                    )),
                    // StreamBuilder<String?>(
                    //   stream: messageHandler.sentMessageController.stream,
                    //   builder: (context, snapshot) {
                    //     if (snapshot.data != "") {
                    //       return TextMessageLoadingWidget(
                    //         message: snapshot.data ?? "N/A",
                    //       );
                    //     } else {
                    //       return Container(
                    //         height: 20,
                    //         width: 100,
                    //         color: Colors.red,
                    //       );
                    //     }
                    //   },
                    // ),
                    SenderActionWidget(chatId: widget.chatId),
                  ],
                )),
          );
        }
      },
    );
  }
}
