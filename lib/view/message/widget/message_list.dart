import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_go/provider/message/message_handler.dart';
import 'package:travel_go/socket/socket_service.dart';
import 'package:travel_go/util/ui_helper.dart';

class MessageListWidget extends StatefulWidget {
  const MessageListWidget({super.key});

  @override
  State<MessageListWidget> createState() => _MessageListWidgetState();
}

class _MessageListWidgetState extends State<MessageListWidget> {
  late SocketService socketService;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    socketService = SocketService();
    socketService.initSocket();
    onGetChatByID("645efa30d13e4f5bb4e76426");
  }

  Future<void> onGetChatByID(String chatId) async {
    await socketService
        .onReceiveChatUserToUser(context: context, chatId: chatId)
        .then((value) async {
      await socketService.onSendUserToUserChat(chatId: chatId);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    socketService.onDisposeListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MessageHandler>(
      builder: (context, value, child) {
        final messageValue = value.personalMessageList;
        return ListView(
          reverse: true,
          children: List.generate(messageValue.length, (index) {
            return Container(
              color: Colors.red,
              child: UIHelper.textHelper(
                  text: messageValue[index].message ?? "N/A"),
            );
          }),
        );
      },
    );
  }
}
