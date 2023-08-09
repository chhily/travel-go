import 'package:flutter/material.dart';
import 'package:travel_go/constant/message_type.dart';
import 'package:travel_go/model/message/personal_message.dart';
import 'package:travel_go/view/message/widget/receiver_image.dart';
import 'package:travel_go/view/message/widget/receiver_message.dart';
import 'package:travel_go/view/message/widget/sender_image.dart';
import 'package:travel_go/view/message/widget/sender_message.dart';

class ValidatedMessageTypeWidget extends StatelessWidget {
  final PersonalMessageModel? personalMessageModel;
  const ValidatedMessageTypeWidget(
      {super.key, required this.personalMessageModel});

  @override
  Widget build(BuildContext context) {
    if (personalMessageModel?.senderId == "6359fb7d96cd484ba17e54f7") {
      return buildSenderWidget();
    } else {
      return buildReceiverWidget();
    }
  }

  Widget buildSenderWidget() {
    if (personalMessageModel?.type == MessageType.textType) {
      return SenderMessageWidget(message: personalMessageModel?.message ?? "");
    } else if (personalMessageModel?.type == MessageType.photoType) {
      return SenderImageWidget(imageUrl: personalMessageModel?.photoUrl ?? "");
    } else {
      return const Placeholder(
        fallbackHeight: 100,
        fallbackWidth: 100,
      );
    }
  }

  Widget buildReceiverWidget() {
    if (personalMessageModel?.type == MessageType.textType) {
      return ReceiverMessageWidget(
          message: personalMessageModel?.message ?? "");
    } else if (personalMessageModel?.type == MessageType.photoType) {
      return ReceiverImageWidget(
          imageUrl: personalMessageModel?.photoUrl ?? "");
    } else {
      return const Placeholder(
        fallbackHeight: 100,
        fallbackWidth: 100,
      );
    }
  }
}