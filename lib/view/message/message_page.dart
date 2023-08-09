import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_go/provider/message/message_handler.dart';
import 'package:travel_go/view/message/widget/message_appbar.dart';
import 'package:travel_go/view/message/widget/message_list.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  late MessageHandler messageHandler;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    messageHandler = Provider.of<MessageHandler>(context, listen: false);
    messageHandler.onGetReceiverInfo();
    messageHandler.onInitPage();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // messageHandler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MessageAppBar(
          imgUrl: messageHandler.receiverInfo?.photoUrl ?? " ",
          username: messageHandler.receiverInfo?.firstName ?? "N/A"),
      body: const MessageListWidget(),
    );
  }
}
