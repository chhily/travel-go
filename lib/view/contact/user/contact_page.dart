import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/constant/app_url.dart';
import 'package:travel_go/provider/message/contact_handler.dart';
import 'package:travel_go/view/contact/widget/item_contact.dart';
import 'package:travel_go/view/message/message_page.dart';
import 'package:travel_go/widget/pagination_handler.dart';
import 'package:collection/collection.dart';

class UserContactPage extends StatefulWidget {
  const UserContactPage({super.key, this.dataLoader});
  final Future<void> Function()? dataLoader;

  @override
  State<UserContactPage> createState() => _UserContactPageState();
}

class _UserContactPageState extends State<UserContactPage>
    with AutomaticKeepAliveClientMixin {

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<UserContactHandler>(
      builder: (context, valueProvider, child) {
        final contactList = valueProvider.userContactList;
        return PaginationWidgetHandler(
          isReverse: false,
          emptyWidget: const SizedBox.shrink(),
          hasMoreData: valueProvider.contactPagination != null
              ? contactList.length < valueProvider.contactPagination!.total
              : false,
          dataLoader: widget.dataLoader,
          separatorBuilder: (context, index) => VerticalSpacing.medium,
          itemCount: contactList.length,
          itemWidget: (context, index) {
            final itemValue = contactList.elementAt(index);
            final receiver = itemValue.receiver
                ?.firstWhereOrNull((element) => element.id != AppUrl.senderId);

            return ItemContactWidget(
              receiverInfo: receiver,
              timeAgo: itemValue.lastMessage?.createdAt,
              unReadCount: itemValue.unreadMessagesCount,
              lastMessage:
                  valueProvider.onChangeLastMessage(itemValue.lastMessage),
              onTap: () {
                debugPrint("receiver id ${receiver?.id}, ${itemValue.id}");
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return MessagePage(
                      isUserStore: false,
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

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
