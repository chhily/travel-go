import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/constant/app_url.dart';
import 'package:travel_go/provider/message/message_handler.dart';
import 'package:travel_go/socket/socket_service.dart';
import 'package:travel_go/view/message/widget/date_time/date_time_sent.dart';
import 'package:travel_go/view/message/widget/date_time/date_time_since.dart';
import 'package:travel_go/view/message/widget/validate_message_type.dart';
import 'package:travel_go/widget/loading_helper.dart';
import 'package:travel_go/widget/pagination_handler.dart';

class MessageListWidget extends StatefulWidget {
  const MessageListWidget({super.key});

  @override
  State<MessageListWidget> createState() => _MessageListWidgetState();
}

class _MessageListWidgetState extends State<MessageListWidget> {
  late SocketService socketService;
  late MessageHandler messageHandler;
  int pageKey = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onInitSocket();
    messageHandler = Provider.of<MessageHandler>(context, listen: false);
  }

  onInitSocket() {
    Provider.of<MessageHandler>(context, listen: false);
    socketService = SocketService();
    socketService.initSocket();
    onGetChatByID(AppUrl.chatId);
  }

  Future<void> onGetChatByID(String chatId) async {
    await socketService
        .onEmitMessage(chatId: chatId, pageKey: pageKey)
        .then((value) async {
      await socketService.onReceiveChatUserToUser(
          context: context, chatId: chatId);
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
      builder: (context, valueNotifier, child) {
        final messageValue = valueNotifier.personalMessageList;
        if (messageValue.isEmpty) {
          return const Loadinghelper();
        }
        return PaginationWidgetHandler(
          dataLoader: () async {
            if (messageValue.length >= 10) {
              pageKey += 1;
              valueNotifier.getMessagePagination != null &&
                  pageKey <=
                      (valueNotifier.personalMessage!.pagination!.total / 10)
                          .ceil();
              await socketService.onEmitMessage(
                  chatId: AppUrl.chatId, pageKey: pageKey);
            }
          },
          hasMoreData: valueNotifier.personalMessage!.pagination != null
              ? messageValue.length <
                  valueNotifier.personalMessage!.pagination!.total
              : false,
          separatorBuilder: (context, index) => VerticalSpacing.medium,
          itemCount: messageValue.length,
          itemWidget: (context, index) {
            final itemValue = messageValue.elementAt(index);
            return Column(
              children: [
                if (index == messageValue.length - 1 ||
                    messageValue[(index + 1) > messageValue.length - 1
                                ? index
                                : index + 1]
                            .createdAt
                            ?.day !=
                        itemValue.createdAt?.day) ...[
                  DateTimeSinceWidget(sinceAgo: itemValue.createdAt),
                ],
                ValidatedMessageTypeWidget(
                  personalMessageModel: itemValue,
                ),
                DateTimeSentWidget(
                  isYourMessage:
                      itemValue.senderId == "6359fb7d96cd484ba17e54f7"
                          ? true
                          : false,
                  sentAgo: itemValue.createdAt,
                )
              ],
            );
          },
        );
      },
    );
  }
}
