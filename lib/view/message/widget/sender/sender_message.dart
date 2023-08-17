import 'package:flutter/material.dart';
import 'package:travel_go/constant/app_color.dart';
import 'package:travel_go/util/ui_helper.dart';
import 'package:travel_go/base/extension.dart';

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
        decoration: BoxDecoration(
          borderRadius: MessageExtension(true).messageRadius,
          color: AppColors.primary,
        ),
        padding: const EdgeInsets.all(8),
        child: UIHelper.textHelper(
          text: message.trim(),
          textColor: AppColors.white,
          maxLines: message.isNotEmpty ? message.length : null,
        ),
      ),
    );
  }
}
