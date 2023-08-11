import 'package:flutter/material.dart';
import 'package:travel_go/socket/socket_service.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late SocketService socketService;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  onInit() {
    socketService = SocketService();
    socketService.onEmitUserContactList(pageKey: 1).then((value) {
      socketService.onSubUserContactList();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
