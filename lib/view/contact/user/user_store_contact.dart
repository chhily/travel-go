import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/provider/message/user_store_handler.dart';
import 'package:travel_go/widget/pagination_handler.dart';
import 'package:collection/collection.dart';
import '../../../constant/app_url.dart';
import '../../message/message_page.dart';
import '../widget/item_contact.dart';

class UserStorePage extends StatefulWidget {
  const UserStorePage({super.key});

  @override
  State<UserStorePage> createState() => _UserStorePageState();
}

class _UserStorePageState extends State<UserStorePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<UserToStoreHandler>(
      builder: (_, valueProvider, __) {
        final contactList = valueProvider.userStoreContactList;
        if (contactList.isEmpty) {
          return Container(
            width: 100,
            height: 100,
            color: Colors.red,
          );
        }
        return PaginationWidgetHandler(
            hasMoreData: false,
            emptyWidget: const SizedBox.shrink(),
            separatorBuilder: (context, index) => VerticalSpacing.regular,
            itemCount: contactList.length,
            itemWidget: (context, index) {
              final itemValue = contactList.elementAt(index);

              return ItemContactWidget(
                storeReceiverInfo: itemValue.receiverStore,
                timeAgo: itemValue.lastMessage?.createdAt,
                unReadCount: itemValue.unreadMessagesCount,
                lastMessage:
                    valueProvider.onChangeLastMessage(itemValue.lastMessage),
                onTap: () {
                  debugPrint(
                      "receiver id ${itemValue.receiverStore?.id}, ${itemValue.id}");
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return MessagePage(
                        isUserStore: true,
                        chatId: itemValue.id ?? "",
                        receiverId: itemValue.receiverStore?.id ?? "",
                      );
                    },
                  ));
                },
              );
            },
            isReverse: false);
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
