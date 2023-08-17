import 'package:flutter/material.dart';
import 'package:travel_go/constant/app_color.dart';
import 'package:travel_go/constant/app_size.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/constant/app_url.dart';
import 'package:travel_go/model/sub_model/product_item_model.dart';
import 'package:travel_go/util/ui_helper.dart';

class ItemInvoiceAndPaymentWidget extends StatelessWidget {
  final String? prodCurrencySymbol;
  final List<ProductItemModel> productList;
  const ItemInvoiceAndPaymentWidget(
      {super.key, required this.prodCurrencySymbol, required this.productList});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: AppGap.mediumGap,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (productList.isEmpty) {
            return const SizedBox();
          }
          final itemList = productList.elementAt(index);
          return InkWell(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                UIHelper.cacheImageHelper(
                    image:
                        "${itemList.product != null && itemList.product!.photoUrls!.isNotEmpty ? itemList.product?.photoUrls?.first ?? '' : ''}?token=${AppUrl.senderToken}",
                    width: 50,
                    height: 50),
                HorizontalSpacing.regular,
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UIHelper.textHelper(
                          text: itemList.product?.title ?? "N/A",
                          maxLines: 2,
                          fontWeight: FontWeight.bold),
                      VerticalSpacing.medium,
                      Row(
                        children: [
                          UIHelper.currencyText(
                              price: itemList.quantity ?? 0,
                              currency: itemList.unit?.symbol ?? "N/A",
                              fontSize: FontSize.fontSizeMedium),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                            child: Icon(Icons.close_rounded,
                                color: AppColors.textSecondary,
                                size: FontSize.fontSizeMedium),
                          ),
                          UIHelper.currencyText(
                              price: itemList.pricePerUnit ?? 0,
                              currency: prodCurrencySymbol ?? "N/A",
                              fontSize: FontSize.fontSizeMedium),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => VerticalSpacing.small,
        itemCount: productList.length > 2 ? 2 : productList.length);
  }
}
