import 'package:flutter/material.dart';
import 'package:travel_go/socket/socket_service.dart';

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
    onGetChatByID("62d535e82f922961c784aa8b");
  }

  Future<void> onGetChatByID(String chatId) async {
    await socketService
        .onReceiveChatUserToUser(chatId: chatId)
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
    return ListView(
      children: [],
    );
    return const Placeholder();
  }
}
