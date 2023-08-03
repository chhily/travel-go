import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/util/ui_helper.dart';

import '../../../constant/app_color.dart';
import '../../../constant/app_size.dart';

class UserMenuWidget extends StatelessWidget {
  const UserMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const List<IconData> icons = [
      FontAwesomeIcons.user,
      FontAwesomeIcons.wallet,
      FontAwesomeIcons.fileShield,
      FontAwesomeIcons.sliders
    ];

    const List<String> settingTitle = [
      "User",
      "Payments",
      "Security & Privacy",
      "Advanced Settings"
    ];

    const List<String> settingSubTitle = [
      "Manage your account",
      "See you payment",
      "Passwords, Term and Condition...",
      "Preference"
    ];

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => itemMenu(
          iconData: icons[index],
          title: settingTitle[index],
          subTitle: settingSubTitle[index]),
      itemCount: icons.length,
      padding: EdgeInsets.zero,
    );
  }

  Widget itemMenu(
      {required IconData iconData,
      required String title,
      required String subTitle}) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: AppGap.regularGap,
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: AppRadius.regular,
              ),
              child: Icon(
                iconData,
                color: AppColors.white,
                size: 16,
              ),
            ),
            HorizontalSpacing.regular,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UIHelper.textHelper(text: title, fontWeight: FontWeight.bold),
                UIHelper.textHelper(
                    text: subTitle, fontSize: FontSize.fontSizeMedium),
              ],
            ),
            const Spacer(),
            const Icon(FontAwesomeIcons.arrowRight, size: 16),
          ],
        ),
      ),
    );
  }
}
