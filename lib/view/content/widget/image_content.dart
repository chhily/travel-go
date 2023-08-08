import 'package:flutter/material.dart';
import 'package:travel_go/constant/app_size.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/mock/mock_data.dart';
import 'package:travel_go/util/ui_helper.dart';

import '../../../constant/app_color.dart';

class ImageContentWidget extends StatelessWidget {
  const ImageContentWidget({super.key});

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
                  color: AppColors.secondary,
                  width: 1,
                  height: MediaQuery.of(context).size.height * 0.4,
                ),
              ],
            ),
            HorizontalSpacing.small,
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                VerticalSpacing.small,
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UIHelper.textHelper(text: "Username"),
                    UIHelper.textHelper(text: "Description..."),
                  ],
                ),
                VerticalSpacing.regular,
                UIHelper.cacheImageHelper(
                    image: MockData.countryImgUrl[1],
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.35)
              ],
            ),
          ],
        ),
      ],
    );
  }
}
