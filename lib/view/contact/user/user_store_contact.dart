import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/provider/message/user_store_handler.dart';
import 'package:travel_go/widget/pagination_handler.dart';
import '../../message/message_page.dart';
import '../widget/item_contact.dart';

class UserStorePage extends StatefulWidget {
  final Future<void> Function()? dataLoader;
  const UserStorePage({super.key, this.dataLoader});

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
        return PaginationWidgetHandler(
            dataLoader: widget.dataLoader,
            hasMoreData: valueProvider.contactPagination != null
                ? contactList.length < valueProvider.contactPagination!.total
                : false,
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
