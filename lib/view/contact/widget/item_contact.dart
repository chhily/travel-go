import 'package:flutter/material.dart';
import 'package:travel_go/constant/app_color.dart';
import 'package:travel_go/constant/app_size.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/constant/app_url.dart';
import 'package:travel_go/model/receiver_model.dart';
import 'package:travel_go/model/receiver_store.dart';
import 'package:travel_go/util/app_helper.dart';
import 'package:travel_go/base/extension.dart';
import 'package:travel_go/util/ui_helper.dart';

class ItemContactWidget extends StatelessWidget {
  final ReceiverModel? receiverInfo;
  final ReceiverStoreModel? storeReceiverInfo;
  final DateTime? timeAgo;
  final num? unReadCount;
  final String? lastMessage;
  final void Function()? onTap;
  const ItemContactWidget(
      {super.key,
      this.receiverInfo,
      this.timeAgo,
      this.unReadCount,
      this.onTap,
      this.lastMessage,
      this.storeReceiverInfo});

  @override
  Widget build(BuildContext context) {
    return UIHelper.cardHelper(
      colors: AppColors.shadeWhite,
      child: InkWell(
        borderRadius: AppRadius.regular,
        onTap: onTap,
        child: Padding(
          padding: AppGap.smallGap,
          child: Row(
            children: [
              UIHelper.imageAvatarHelper(
                  "${storeReceiverInfo?.photoUrl ?? receiverInfo?.photoUrl}?token=${AppUrl.senderToken}",
                  size: 44),
              HorizontalSpacing.medium,
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        UIHelper.textHelper(
                            text: storeReceiverInfo?.name ??
                                receiverInfo?.fullName ??
                                "N/A",
                            fontWeight: FontWeight.bold),
                        const VerticalDivider(
                            color: AppColors.primary, thickness: 0.5),
                        UIHelper.textHelper(
                          text: AppHelper.timeFormatter(timeAgo: timeAgo),
                        ),
                      ],
                    ),
                  ),
                  VerticalSpacing.small,
                  SizedBox(
                      width:
                          TravelGoExtension(context).mediaQuerySize.width * 0.6,
                      child: UIHelper.textHelper(
                          text: lastMessage ?? "N/A", maxLines: 1)),
                ],
              ),
              const Spacer(),
              unReadCount == 0 || unReadCount == null
                  ? const SizedBox.shrink()
                  : Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: AppRadius.regular),
                      height: 20,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: UIHelper.textHelper(
                          textAlign: TextAlign.center,
                          text: AppHelper.formatNumber(number: unReadCount),
                          textColor: AppColors.white),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
