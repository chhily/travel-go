import 'package:flutter/material.dart';
import 'package:travel_go/constant/app_color.dart';
import 'package:travel_go/constant/app_size.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/model/message/personal_message.dart';
import 'package:travel_go/util/extension.dart';
import 'package:travel_go/util/ui_helper.dart';
import 'package:travel_go/view/message/widget/item_invoice_payment.dart';

class SenderInvoiceWidget extends StatelessWidget {
  final PersonalMessageModel? personalMessageModel;
  const SenderInvoiceWidget({super.key, this.personalMessageModel});

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
                  text: messageText(personalMessageModel?.invoice?.paymentStatus),
                  textColor: AppColors.textPrimary,
                  maxLines: 2),
            ),
            Divider(height: 0, color: AppColors.primary.withOpacity(0.1)),
            ItemInvoiceAndPaymentWidget(
              productList: personalMessageModel?.invoice?.productItems ?? [],
              prodCurrencySymbol: "Riel",
            ),
            Divider(height: 0, color: AppColors.primary.withOpacity(0.1)),
            Material(
              borderRadius: AppRadius.regular,
              color: AppColors.shadeWhite,
              child: Row(
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
                  const Spacer(),
                  Padding(
                    padding: AppGap.mediumGap,
                    child: UIHelper.textHelper(
                      text: personalMessageModel?.invoice?.paymentStatus ?? "N/A",
                      textColor: AppColors.secondary,
                    ),
                  ),
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

    return messages[paymentStatus] ??
        "Purchase order has been created. Please make a payment here.";
  }
}
