import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_go/constant/app_color.dart';
import 'package:travel_go/constant/app_size.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/constant/app_url.dart';
import 'package:travel_go/provider/message/contact_handler.dart';
import 'package:travel_go/util/app_helper.dart';
import 'package:travel_go/util/ui_helper.dart';

import '../../../model/chat/receiver_model.dart';

class ItemContactWidget extends StatelessWidget {
  final ReceiverModel? receiverInfo;
  final DateTime? timeAgo;
  final num? unReadCount;
  final void Function()? onTap;
  const ItemContactWidget(
      {super.key,
      required this.receiverInfo,
      this.timeAgo,
      this.unReadCount,
      this.onTap});

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
                  "${receiverInfo?.photoUrl}?token=${AppUrl.senderToken}",
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
                            text: receiverInfo?.fullName ?? "N/A",
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
                  UIHelper.textHelper(text: "Last Message")
                ],
              ),
              const Spacer(),
              Consumer<ContactHandler>(
                builder: (context, valueListener, child) {
                  if (valueListener.unReadCount == 0) {
                    if (unReadCount == 0 || unReadCount == null) {
                      return const SizedBox.shrink();
                    }else {
                      return Container(
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
                      );
                    }
                  } else {
                    return Container(
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
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
