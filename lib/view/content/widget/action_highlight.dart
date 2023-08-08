import 'package:flutter/material.dart';
import 'package:travel_go/constant/app_color.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/util/app_helper.dart';
import 'package:travel_go/util/ui_helper.dart';

import '../../../mock/mock_data.dart';

class ActionHighLight extends StatelessWidget {
  const ActionHighLight({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < 2; i++)
                Align(
                  widthFactor: 0.5,
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircleAvatar(
                      radius: 21,
                      backgroundColor: AppColors.secondary,
                      child: UIHelper.imageAvatarHelper(
                          MockData.countryImgUrl[i],
                          size: 20),
                    ),
                  ),
                ),
            ],
          ),
          HorizontalSpacing.regular,
          UIHelper.textHelper(
            text:
                "${AppHelper.formatNumber(number: AppHelper.generateRandomNumber(maxNum: 90))} replies",
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: UIHelper.textHelper(text: "•"),
          ),
          UIHelper.textHelper(
            text:
                "${AppHelper.formatNumber(number: AppHelper.generateRandomNumber(maxNum: 1000))} likes",
          ),
        ],
      ),
    );
  }
}
