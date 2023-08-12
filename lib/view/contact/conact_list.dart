import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/constant/app_url.dart';
import 'package:travel_go/provider/message/contact_handler.dart';
import 'package:travel_go/view/contact/widget/item_contact.dart';
import 'package:travel_go/view/message/message_page.dart';
import 'package:travel_go/widget/pagination_handler.dart';
import 'dart:async';

class ContactListWidget extends StatelessWidget {
  final Future<void> Function()? dataLoader;
  const ContactListWidget({super.key, this.dataLoader});

  @override
  Widget build(BuildContext context) {
    return Consumer<ContactHandler>(
      builder: (context, valueProvider, child) {
        final contactList = valueProvider.userContactList;
        return PaginationWidgetHandler(
          emptyWidget: const SizedBox.shrink(),
          hasMoreData: false,
          dataLoader: dataLoader,
          separatorBuilder: (context, index) => VerticalSpacing.medium,
          itemCount: valueProvider.userContactList.length,
          itemWidget: (context, index) {
            final itemValue = contactList.elementAt(index);
            final receiver = itemValue.receiver
                ?.firstWhereOrNull((element) => element.id != AppUrl.senderId);
            return ItemContactWidget(
              receiverInfo: receiver,
              timeAgo: itemValue.lastMessage?.createdAt,
              unReadCount: itemValue.unreadMessagesCount,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return MessagePage(
                      chatId: itemValue.id ?? "",
                      receiverId: receiver?.id ?? "",
                    );
                  },
                ));
              },
            );
          },
        );
      },
    );
  }
}