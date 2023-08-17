import 'package:flutter/material.dart';
import 'package:travel_go/constant/app_color.dart';
import 'package:travel_go/constant/app_size.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/constant/app_url.dart';
import 'package:travel_go/model/sub_model/buy_listing.dart';
import 'package:travel_go/util/extension.dart';
import 'package:travel_go/util/ui_helper.dart';

class SenderBuyListingWidget extends StatelessWidget {
  final BuyListingModel? buyListingModel;
  const SenderBuyListingWidget({
    super.key,
    this.buyListingModel,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: TravelGoExtension(context).mediaQuerySize.width * 0.7,
          minWidth: TravelGoExtension(context).mediaQuerySize.width * 0.3,
        ),
        decoration: BoxDecoration(
          borderRadius: AppRadius.regular,
          color: AppColors.primary,
        ),
        padding: AppGap.mediumGap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            UIHelper.cacheImageHelper(
                image:
                    "${buyListingModel?.photoUrls}?token=${AppUrl.senderToken}",
                height: 50,
                width: 50),
            HorizontalSpacing.medium,
            if (buyListingModel != null) ...[
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  UIHelper.textHelper(
                      text: buyListingModel?.title ?? "N/A",
                      textColor: AppColors.white),
                  VerticalSpacing.small,
                  UIHelper.textHelper(
                      text: buyListingModel?.prices?.join("-") ?? "N/A",
                      textColor: AppColors.white)
                ],
              )
            ] else ...[
              UIHelper.textHelper(
                  text: "Product removed", textColor: AppColors.white)
            ]
          ],
        ),
      ),
    );
  }
}
