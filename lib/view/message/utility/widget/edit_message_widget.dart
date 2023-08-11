import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_go/constant/app_color.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/util/ui_helper.dart';

class EditMessageWidget extends StatelessWidget {
  final void Function()? onClose;
  final String message;
  const EditMessageWidget({super.key, this.onClose, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: AppColors.primary,
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: IntrinsicHeight(
        child: Row(
          children: [
            const Icon(FontAwesomeIcons.pen,
                color: AppColors.secondary, size: 20),
            HorizontalSpacing.regular,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  UIHelper.textHelper(
                      text: "Edit message",
                      textColor: AppColors.secondary,
                      fontWeight: FontWeight.bold),
                  VerticalSpacing.small,
                  Flexible(
                    child: UIHelper.textHelper(
                        text: message, textColor: AppColors.white, maxLines: 2),
                  ),
                ],
              ),
            ),
            HorizontalSpacing.small,
            InkWell(
              onTap: onClose,
              child: const Icon(FontAwesomeIcons.circleXmark,
                  color: AppColors.contentColor, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}
