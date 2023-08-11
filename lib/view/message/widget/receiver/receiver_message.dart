import 'package:flutter/material.dart';
import 'package:travel_go/constant/app_color.dart';
import 'package:travel_go/util/ui_helper.dart';

class ReceiverMessageWidget extends StatelessWidget {
  final String message;
  const ReceiverMessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
          maxHeight: MediaQuery.of(context).size.height * 0.35,
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(12),
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          color: AppColors.secondary,
        ),
        padding: const EdgeInsets.all(8),
        child: UIHelper.textHelper(
            text: message.trim(),
            textColor: AppColors.white,
            maxLines: message.length),
      ),
    );
  }
}
