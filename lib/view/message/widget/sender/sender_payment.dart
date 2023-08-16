import 'package:flutter/material.dart';
import 'package:travel_go/constant/app_color.dart';
import 'package:travel_go/constant/app_size.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/model/message/personal_message.dart';
import 'package:travel_go/util/extension.dart';
import 'package:travel_go/util/ui_helper.dart';
import 'package:travel_go/view/message/widget/item_invoice_payment.dart';

class SenderPaymentWidget extends StatelessWidget {
  final PersonalMessageModel? personalMessageModel;
  const SenderPaymentWidget({super.key, this.personalMessageModel});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(
            maxWidth: TravelGoExtension(context).mediaQuerySize.width * 0.6),
        decoration: BoxDecoration(
            borderRadius: MessageExtension(true).messageRadius,
            color: AppColors.shadeWhite),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              constraints: BoxConstraints(
                  minWidth:
                      TravelGoExtension(context).mediaQuerySize.width * 0.6),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              padding: AppGap.mediumGap,
              child: UIHelper.textHelper(
                  text:
                      messageText(personalMessageModel?.payment?.paymentStatus),
                  textColor: AppColors.textPrimary,
                  maxLines: 2),
            ),
            Divider(height: 0, color: AppColors.primary.withOpacity(0.1)),
            ItemInvoiceAndPaymentWidget(
              productList: personalMessageModel?.payment?.productItems ?? [],
              prodCurrencySymbol:
                  personalMessageModel?.payment?.currency?.symbol,
            ),
            Divider(height: 0, color: AppColors.primary.withOpacity(0.1)),
            Material(
              borderRadius: AppRadius.regular,
              color: AppColors.shadeWhite,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: AppGap.mediumGap,
                      child: UIHelper.textHelper(
                          text: "View",
                          textColor: AppColors.secondary,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                  if (personalMessageModel?.payment?.paymentStatus ==
                      "CONFIRMED")
                    ...[
                      const SizedBox()
                    ]
                  else ...[
                    const Spacer(),
                    InkWell(
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(12)),
                      onTap: () {},
                      child: Padding(
                        padding: AppGap.mediumGap,
                        child: UIHelper.textHelper(
                          text: personalMessageModel?.payment?.paymentStatus ??
                              "N/A",
                          textColor: AppColors.secondary,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            )
            // UIHelper.buttonHelper(onPressed: () {}, buttonText: "Pay"),
          ],
        ),
      ),
    );
  }

  String messageText(String? paymentStatus) {
    final messages = {
      "PAID": "Buyer sends payment for this order.",
      "CONFIRMED": "Purchase orders have been paid.",
      "COD": "Customer is going to pay on delivery",
    };

    return messages[paymentStatus] ?? "Buyer sends payment for this order.";
  }
}
