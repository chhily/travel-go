import 'package:flutter/material.dart';
import 'package:travel_go/constant/app_color.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/mock/mock_data.dart';
import 'package:travel_go/util/app_helper.dart';
import 'package:travel_go/util/ui_helper.dart';
import 'package:travel_go/view/content/widget/action_highlight.dart';
import 'package:travel_go/view/content/widget/user_action.dart';

class ImageContentWidget extends StatelessWidget {
  final int index;
  const ImageContentWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  color: AppColors.secondary,
                  width: 1,
                  height:
                      (AppHelper.generateRandomString(50).length.toDouble() +
                              MediaQuery.of(context).size.height) /
                          3.1,
                  constraints: BoxConstraints(
                    minHeight: 40,
                    maxHeight: MediaQuery.of(context).size.height * 0.8,
                  ),
                ),
              ],
            ),
            HorizontalSpacing.small,
            Expanded(
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.6,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    VerticalSpacing.small,
                    Container(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.2,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          UIHelper.textHelper(
                              text: "Lim Chhily", fontWeight: FontWeight.bold),
                          UIHelper.textHelper(
                              text: AppHelper.generateRandomString(50),
                              maxLines: 5),
                        ],
                      ),
                    ),
                    VerticalSpacing.regular,
                    UIHelper.cacheImageHelper(
                        image: index > MockData.countryImgUrl.length
                            ? ""
                            : MockData.countryImgUrl[index],
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.4),
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
    );
  }
}
