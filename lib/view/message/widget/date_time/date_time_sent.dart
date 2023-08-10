import 'package:flutter/material.dart';
import 'package:travel_go/util/ui_helper.dart';

import '../../../../constant/app_color.dart';
import '../../../../constant/app_size.dart';
import '../../../../constant/app_spacing.dart';
import '../../../../util/app_helper.dart';

class DateTimeSentWidget extends StatelessWidget {
  final Stream<int>? stream;
  final bool isYourMessage;
  final DateTime? sentAgo;
  const DateTimeSentWidget(
      {super.key,
      required this.sentAgo,
      this.stream,
      required this.isYourMessage});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        stream: stream,
        builder: (context, valueIndex) {
          if (valueIndex.data == 0) {
            return Column(
              children: [
                Center(
                  child: UIHelper.textHelper(
                      text: AppHelper.timeFormatter(timeAgo: sentAgo),
                      fontSize: FontSize.fontSizeBig),
                ),
              ],
            );
          } else {
            return _buildSeenAgo();
            return Center(
              child: UIHelper.textHelper(
                  text: AppHelper.timeFormatter(timeAgo: sentAgo),
                  fontSize: FontSize.fontSizeBig),
            );
          }
        });
  }

  Widget _buildSeenAgo() {
    return Row(
      mainAxisAlignment:
          !isYourMessage ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        if (!isYourMessage)
          const Icon(
            Icons.done_all,
            color: AppColors.black,
            size: 14,
          ),
        HorizontalSpacing.small,
        // if (isYourMessage && isEdited) ...[
        //   UIHelper.textHelper(
        //     text: "chat.edited".tr(),
        //     textColor: AppColor.textSecondary,
        //     fontSize: 10.0,
        //   ),
        //   HorizontalSpacing.medium,
        // ],
        UIHelper.textHelper(
          text: AppHelper.timeFormatter(timeAgo: sentAgo),
          textColor: AppColors.black,
          fontSize: FontSize.fontSizeMedium,
        ),
        // if (!isYourMessage && isEdited) ...[
        //   const SpaceX(4),
        //   CustomText(
        //     text: "chat.edited".tr(),
        //     textColor: AppColor.textSecondary,
        //     fontSize: 10.0,
        //     isOverflow: false,
        //   ),
        // ],
        HorizontalSpacing.small,
        // if (isYourMessage && isSeen)
        //   const Icon(
        //     Icons.done_all,
        //     color: AppColor.textSecondary,
        //     size: 15,
        //   ),
      ],
    );
  }
}
