import 'package:flutter/material.dart';
import 'package:travel_go/constant/app_size.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/util/ui_helper.dart';

import '../../../constant/app_color.dart';

class HighlightCardWidget extends StatelessWidget {
  const HighlightCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.45,
      child: ListView.separated(
        separatorBuilder: (context, index) => HorizontalSpacing.big,
        itemCount: 5,
        itemBuilder: (context, index) {
          return buildInfoCard(context);
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget buildInfoCard(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * 0.25,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UIHelper.cacheImageHelper(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.25,
              image:
                  "https://i.pinimg.com/564x/61/be/53/61be5315da1d09bab542478dd3f6d5e1.jpg"),
          VerticalSpacing.regular,
          UIHelper.textHelper(
              text: "Name of Destination", fontSize: FontSize.fontSizeBig),
          VerticalSpacing.small,
          UIHelper.textHelper(
              text:
                  "Outline project component link content stroke group. Flatten community library.",
              fontSize: FontSize.fontSizeRegular,
              textColor: AppColors.textSecondary),
          VerticalSpacing.regular,
          UIHelper.currencyText(
              price: 10000,
              currency: "USD",
              isSlash: true,
              slashInfo: "Day",
              fontWeight: FontWeight.bold)
        ],
      ),
    );
  }
}
