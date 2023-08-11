import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_go/constant/app_color.dart';
import 'package:travel_go/model/message/receiver_model.dart';
import 'package:travel_go/provider/message/message_handler.dart';
import 'package:travel_go/view/message/message_list.dart';
import 'package:travel_go/view/message/utility/sender_action.dart';
import 'package:travel_go/view/message/widget/loader/message_text_loader.dart';
import 'package:travel_go/view/message/widget/message_appbar.dart';
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
    messageHandler.onInitTextController();
  }

  Future<ReceiverModel?> onInitData() async {
    final data = await messageHandler.onGetReceiverInfo();
    return data;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    messageHandler.onDispose();
    // messageHandler.dispose();
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
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
                backgroundColor: AppColors.white,
                appBar: MessageAppBar(
                    imgUrl: messageHandler.receiverInfo?.photoUrl ?? "",
                    username:
                        " ${messageHandler.receiverInfo?.lastName} ${messageHandler.receiverInfo?.firstName}"),
                body: Column(
                  children: [
                    const Expanded(child: MessageListWidget()),
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
                    SenderActionWidget(
                        textEditingController: messageHandler.textMessageCT,
                        onSendMessage: () {
                          messageHandler.onSendTextMessage();
                        }),
                  ],
                )),
          );
        }
      },
    );
  }
}
