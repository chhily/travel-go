import 'package:flutter/material.dart';
import 'package:travel_go/view/message/widget/message_appbar.dart';
import 'package:travel_go/view/message/widget/message_list.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MessageAppBar(),
      body: MessageListWidget(),
    );
    return const Placeholder();
  }
}
