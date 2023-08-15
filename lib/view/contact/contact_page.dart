import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_go/provider/message/contact_handler.dart';
import 'package:travel_go/socket/socket_service.dart';
import 'package:travel_go/view/contact/conact_list.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  late SocketService socketService;
  late ContactHandler contactHandler;
  int pageKey = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    contactHandler = Provider.of<ContactHandler>(context, listen: false);
    onInit();
  }

  Future<void> onInit() async {
    socketService = SocketService();
    socketService.initSocket();
    await socketService
        .onEmitUserContactList(pageKey: pageKey)
        .then((value) async {
      await socketService.onSubUserContactList(context: context);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose

    socketService.onDisposeListener();

    contactHandler.onDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        child: ContactListWidget(
          dataLoader: () async {
            debugPrint("on fetch more data");
            if (contactHandler.userContactList.length >= 10) {
              debugPrint("length is greater than 10");
              pageKey += 1;
              contactHandler.userContactList.isNotEmpty &&
                  pageKey <=
                      (contactHandler.contactListModel!.pagination!.total / 10)
                          .ceil();
              await socketService.onEmitUserContactList(pageKey: pageKey);
            }
          },
        ),
      ),
    );
  }
}
