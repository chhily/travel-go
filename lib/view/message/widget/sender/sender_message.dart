import 'package:flutter/material.dart';
import 'package:travel_go/constant/app_color.dart';
import 'package:travel_go/util/ui_helper.dart';

class SenderMessageWidget extends StatelessWidget {
  final String message;
  const SenderMessageWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
          maxHeight: MediaQuery.of(context).size.height * 0.35,
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(12),
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          color: AppColors.primary,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: UIHelper.textHelper(
          text: message,
          textColor: AppColors.white,
          maxLines: message.length,
        ),
      ),
    );
  }
}