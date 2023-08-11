import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/constant/app_url.dart';
import 'package:travel_go/model/message/personal_message.dart';
import 'package:travel_go/provider/message/message_handler.dart';
import 'package:travel_go/socket/socket_service.dart';
import 'package:travel_go/view/message/widget/date_time/date_time_sent.dart';
import 'package:travel_go/view/message/widget/date_time/date_time_since.dart';
import 'package:travel_go/view/message/widget/validate_message_type.dart';
import 'package:travel_go/widget/pagination_handler.dart';

class MessageListWidget extends StatelessWidget {
  final Future<void> Function()? dataLoader;
  const MessageListWidget({super.key, this.dataLoader});

  @override
  Widget build(BuildContext context) {
    return Consumer<MessageHandler>(
      builder: (context, valueNotifier, child) {
        final messageValue = valueNotifier.personalMessageList;
        return PaginationWidgetHandler(
          receiverImgUrl: valueNotifier.receiverInfo?.photoUrl,
          receiverUsername:
              "${valueNotifier.receiverInfo?.lastName} ${valueNotifier.receiverInfo?.firstName}",
          dataLoader: dataLoader,
          hasMoreData: valueNotifier.personalMessage?.pagination != null
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
                      itemValue.senderId == AppUrl.senderId ? true : false,
                  sentAgo: itemValue.createdAt,
                  isEditTed: itemValue.histories?.isNotEmpty ?? false,
                )
              ],
            );
          },
        );
      },
    );
  }

  // Future<void> onGetMoreData(
  //     {required List<PersonalMessageModel> messageValue,
  //     required int pageKey,
  //     required MessageHandler valueNotifier}) async {
  //   if (messageValue.length >= 10) {
  //     pageKey += 1;
  //     valueNotifier.getMessagePagination != null &&
  //         pageKey <=
  //             (valueNotifier.personalMessage!.pagination!.total / 10).ceil();
  //     await socketService.onEmitMessage(
  //         chatId: AppUrl.chatId, pageKey: pageKey);
  //   }
  // }
}
