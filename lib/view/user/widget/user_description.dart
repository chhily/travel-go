import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/util/app_helper.dart';

import '../../../constant/app_color.dart';
import '../../../constant/app_size.dart';
import '../../../util/ui_helper.dart';

class UserDescriptionWidget extends StatelessWidget {
  const UserDescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UIHelper.textHelper(
            text: "Username",
            fontWeight: FontWeight.bold,
            fontSize: FontSize.fontSizeBig),
        UIHelper.textHelper(
          text: "@username",
          textColor: AppColors.textSecondary,
        ),
        VerticalSpacing.regular,
        UIHelper.textHelper(text: "user description..."),
        VerticalSpacing.medium,
        UIHelper.linkButtonHelper(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Wrap(
                direction: Axis.horizontal,
                crossAxisAlignment: WrapCrossAlignment.start,
                alignment: WrapAlignment.start,
                spacing: 8,
                runAlignment: WrapAlignment.start,
                children: List.generate(
                  2,
                  (index) {
                    return Row(
                      children: [
                        const Icon(FontAwesomeIcons.locationDot, size: 12),
                        HorizontalSpacing.small,
                        UIHelper.textHelper(
                            text: "Location $index",
                            textColor: AppColors.secondary,
                            fontSize: FontSize.fontSizeRegular)
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        VerticalSpacing.medium,
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              FontAwesomeIcons.calendar,
              size: 12,
            ),
            HorizontalSpacing.small,
            UIHelper.textHelper(
                text: "Joined ${AppHelper.dateFormatter(
              dateTime: DateTime.now(),
            )}")
          ],
        ),
      ],
    );
  }
}
