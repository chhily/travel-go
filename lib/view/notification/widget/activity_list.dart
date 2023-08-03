import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_go/constant/app_color.dart';
import 'package:travel_go/constant/app_size.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/util/app_helper.dart';
import 'package:travel_go/util/ui_helper.dart';

class ActivityListWidget extends StatelessWidget {
  const ActivityListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) => itemActivity(
              title: AppHelper.generateRandomString(6),
              dateTime: AppHelper.generateRandomDateTime(
                DateTime(2022, 8, 1),
                DateTime(2023, 8, 31),
              ),
              onTap: () {},
            ),
        separatorBuilder: (context, index) => const Divider(
            thickness: 0.2, color: AppColors.textSecondary, height: 0),
        itemCount: 6);
  }

  Widget itemActivity(
      {required String title,
      required DateTime dateTime,
      void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: AppGap.regularGap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              backgroundColor: AppColors.secondary,
              radius: 20,
              child: Icon(FontAwesomeIcons.signsPost, size: 16),
            ),
            HorizontalSpacing.regular,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  UIHelper.textHelper(text: title),
                  VerticalSpacing.medium,
                  UIHelper.textHelper(
                    text: AppHelper.dateTimeFormatter(dateTime: dateTime),
                    textColor: AppColors.textSecondary,
                    fontSize: FontSize.fontSizeMedium,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
