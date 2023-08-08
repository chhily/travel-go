import 'package:flutter/material.dart';
import 'package:travel_go/constant/app_color.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/mock/mock_data.dart';
import 'package:travel_go/util/app_helper.dart';
import 'package:travel_go/util/ui_helper.dart';
import 'package:travel_go/view/content/widget/user_action.dart';

import 'action_highlight.dart';

class TextContentWidget extends StatelessWidget {
  const TextContentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width * 0.8,
        maxWidth: MediaQuery.of(context).size.width * 0.8,
        maxHeight: MediaQuery.of(context).size.height * 0.35,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  UIHelper.imageAvatarHelper(
                    MockData.userCoverImg,
                    size: 36,
                  ),
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      color: AppColors.secondary,
                      width: 1,
                      height:
                          AppHelper.generateRandomString(20).length.toDouble() /
                              2.3,
                      constraints: BoxConstraints(
                        minHeight: 40,
                        maxHeight: MediaQuery.of(context).size.height * 0.35,
                      ),
                    ),
                  ),
                ],
              ),
              HorizontalSpacing.small,
              Expanded(
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.35,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      VerticalSpacing.small,
                      UIHelper.textHelper(
                          text: "Username", fontWeight: FontWeight.bold),
                      UIHelper.textHelper(
                          text: AppHelper.generateRandomString(20),
                          maxLines: AppHelper.generateRandomString(20).length),
                      VerticalSpacing.regular,
                      const UserActionButton(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const ActionHighLight(),
        ],
      ),
    );
  }
}
