import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_go/constant/app_color.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/view/message/utility/widget/sender_text_field.dart';

class SenderActionWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final void Function()? onSendMessage;
  const SenderActionWidget({super.key, required this.textEditingController, this.onSendMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: AppGap.smallGap,
      color: AppColors.shadeWhite,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: SenderTextFieldWidget(
              textEditingController: textEditingController,
            ),
          ),
          InkWell(
            onTap: onSendMessage,
            child: const Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(
                Icons.send,
                size: 24,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(
                Icons.add_photo_alternate_rounded,
                size: 24,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(
                FontAwesomeIcons.microphone,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
