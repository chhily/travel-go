import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_go/constant/app_size.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/mock/mock_data.dart';
import 'package:travel_go/util/app_helper.dart';
import 'package:travel_go/util/ui_helper.dart';

import '../../../constant/app_color.dart';
import '../../../widget/bottom_bar.dart';

class SuggestionPlaceWidget extends StatelessWidget {
  const SuggestionPlaceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.zero,
        controller: InheritedDataProvider.of(context).scrollController,
        itemBuilder: (context, index) {
          return suggestionItem(
              title: MockData.country[index],
              imgUrl: MockData.countryImgUrl[index],
              placeCount: AppHelper.generateRandomNumber(),
              place: "N/A");
        },
        separatorBuilder: (context, index) => const Divider(
            thickness: 0.2, color: AppColors.textSecondary, height: 0),
        itemCount: MockData.country.length);
  }

  Widget suggestionItem(
      {required String title,
      required String imgUrl,
      required String place,
      required num placeCount}) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: AppGap.regularGap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            UIHelper.cacheImageHelper(image: imgUrl, width: 50, height: 40),
            HorizontalSpacing.regular,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UIHelper.textHelper(
                      text: title,
                      fontSize: FontSize.fontSizeBig,
                      fontWeight: FontWeight.bold),
                  UIHelper.textHelper(
                      text: place,
                      textColor: AppColors.textSecondary,
                      fontSize: FontSize.fontSizeRegular),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(FontAwesomeIcons.locationDot, size: 14),
                HorizontalSpacing.small,
                UIHelper.textHelper(
                  text: "$placeCount",
                  fontSize: FontSize.fontSizeRegular,
                  textColor: AppColors.textSecondary,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
