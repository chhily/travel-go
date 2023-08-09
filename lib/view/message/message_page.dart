import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_go/model/message/personal_message.dart';
import 'package:travel_go/model/message/receiver_model.dart';
import 'package:travel_go/provider/message/message_handler.dart';
import 'package:travel_go/socket/socket_service.dart';
import 'package:travel_go/util/ui_helper.dart';
import 'package:travel_go/view/message/widget/message_appbar.dart';
import 'package:travel_go/view/message/widget/message_list.dart';
import 'package:travel_go/widget/loading_helper.dart';

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
  }

  Future<ReceiverModel?> onInitData() async {
    final _messageHandler = Provider.of<MessageHandler>(context, listen: false);
    final data = await _messageHandler.onGetReceiverInfo();
    return data;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    messageHandler.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ReceiverModel?>(
      future: onInitData(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const Loadinghelper();
        } else {
          return Scaffold(
              appBar: MessageAppBar(
                  imgUrl: messageHandler.receiverInfo?.photoUrl ?? " ",
                  username: messageHandler.receiverInfo?.firstName ?? "N/A"),
              body: const MessageListWidget());
        }
      },
    );
  }
}
