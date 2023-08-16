import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travel_go/provider/message/contact_handler.dart';
import 'package:travel_go/socket/socket_service.dart';
import 'package:travel_go/view/contact/user/contact_page.dart';
import 'package:travel_go/view/contact/user/user_store_contact.dart';
import 'package:travel_go/view/contact/widget/tab_widget.dart';

class UserChatPage extends StatefulWidget {
  const UserChatPage({super.key});

  @override
  State<UserChatPage> createState() => _UserChatPageState();
}

class _UserChatPageState extends State<UserChatPage>
    with TickerProviderStateMixin {
  // late TabController tabController;
  late SocketService socketService;
  late UserContactHandler contactHandler;
  int pageKey = 1;
  int storePageKey = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // tabController = TabController(
    //   length: 2,
    //   vsync: this,
    //   initialIndex: 0,
    // );
    contactHandler = Provider.of<UserContactHandler>(context, listen: false);
    onInit();
  }

  Future<void> onInit() async {
    socketService = SocketService();
    socketService.initSocket();
    // User to Users
    await socketService
        .onEmitUserContactList(pageKey: pageKey)
        .then((value) async {
      await socketService.onSubUserContactList(context: context);
    });

    // User to Stores
    await socketService
        .onEmitUserStoresContactList(pageKey: storePageKey)
        .then((value) async {
      await socketService.onSubUserStoresContactList(context: context);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose

    socketService.onDisposeListener();
    contactHandler.onDispose();
    // tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: TabWidget(
        // controller: tabController,
        tabBarView: TabBarView(
          // controller: tabController,
          children: [
            UserContactPage(
              dataLoader: () async {
                debugPrint("on fetch more data");
                if (contactHandler.userContactList.length >= 10) {
                  debugPrint("length is greater than 10");
                  pageKey += 1;
                  contactHandler.userContactList.isNotEmpty &&
                      pageKey <=
                          (contactHandler.contactListModel!.pagination!.total /
                                  10)
                              .ceil();
                  await socketService.onEmitUserContactList(pageKey: pageKey);
                }
              },
            ),
            const UserStorePage()
          ],
        ),
      ),
    );
  }
}
