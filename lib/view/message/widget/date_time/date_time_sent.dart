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
  final bool isEditTed;
  const DateTimeSentWidget(
      {super.key,
      required this.sentAgo,
      this.stream,
      required this.isYourMessage,
      required this.isEditTed});

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

          }
        });
  }

  Widget _buildSeenAgo() {
    return Row(
      mainAxisAlignment:
          !isYourMessage ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        if (!isYourMessage) ...[
          const Icon(
            Icons.done_all,
            color: AppColors.black,
            size: 14,
          ),
          HorizontalSpacing.small,
          UIHelper.textHelper(
            text: AppHelper.timeFormatter(timeAgo: sentAgo),
            fontSize: FontSize.fontSizeMedium,
          ),
          HorizontalSpacing.small,
          if (isEditTed) ...[
            UIHelper.textHelper(
              text: "edited",
              fontSize: FontSize.fontSizeMedium,
            )
          ]
        ] else ...[
          UIHelper.textHelper(
            text: AppHelper.timeFormatter(timeAgo: sentAgo),
            textColor: AppColors.textPrimary,
            fontSize: FontSize.fontSizeMedium,
          ),
          HorizontalSpacing.small,
          if (isEditTed) ...[
            UIHelper.textHelper(
              text: "edited",
              fontSize: FontSize.fontSizeMedium,
            )
          ]
        ]
      ],
    );
  }
}
