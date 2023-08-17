import 'package:flutter/material.dart';
import 'package:travel_go/constant/app_color.dart';
import 'package:travel_go/constant/app_size.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/constant/app_url.dart';
import 'package:travel_go/model/sub_model/product_model.dart';
import 'package:travel_go/util/extension.dart';
import 'package:travel_go/util/ui_helper.dart';

class ReceiverProductWidget extends StatelessWidget {
  final ProductModel? productModel;
  const ReceiverProductWidget({super.key, this.productModel});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
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
                image: "${productModel?.photoUrls}?token=${AppUrl.senderToken}",
                height: 50,
                width: 50),
            HorizontalSpacing.medium,
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                UIHelper.textHelper(
                    text: productModel?.title ?? "N/A",
                    textColor: AppColors.white),
                VerticalSpacing.small,
                UIHelper.textHelper(
                    text: productModel?.prices?.join("-") ?? "N/A",
                    textColor: AppColors.white)
              ],
            )
          ],
        ),
      ),
    );
  }
}
