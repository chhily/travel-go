import 'package:flutter/material.dart';
import 'package:travel_go/constant/app_color.dart';

import 'package:travel_go/view/message/widget/sender/sender_message.dart';

class TextMessageLoadingWidget extends StatelessWidget {
  final String message;
  const TextMessageLoadingWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SenderMessageWidget(message: message),
        const Icon(Icons.circle_rounded, color: AppColors.black),
      ],
    );
  }
}
