import 'package:flutter/material.dart';
import 'package:travel_go/constant/app_size.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/mock/mock_data.dart';
import 'package:travel_go/util/ui_helper.dart';
import 'package:travel_go/view/details/item_details.dart';

import '../../../constant/app_color.dart';

class HighlightCardWidget extends StatelessWidget {
  final List<ItemObject> itemValue;
  const HighlightCardWidget({super.key, required this.itemValue});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.45,
      child: ListView.separated(
        separatorBuilder: (context, index) => HorizontalSpacing.big,
        itemCount: itemValue.length,
        itemBuilder: (context, index) {
          final item = itemValue.elementAt(index);
          return GestureDetector(
              onTap: () async {
                // UIHelper.loadingDialogHelper(context);
                // await Future.delayed(const Duration(seconds: 1))
                //     .whenComplete(() {
                //   Navigator.pop(context);
                // }).then((value) {
                //
                // });

                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return ItemDetails(itemObject: item);
                  },
                ));
              },
              child: buildInfoCard(context, item));
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget buildInfoCard(BuildContext context, ItemObject item) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * 0.25,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: item.title ?? "N/A",
            child: UIHelper.cacheImageHelper(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.25,
                image: item.image ?? ""),
          ),
          VerticalSpacing.regular,
          UIHelper.textHelper(
              text: item.title ?? "N/A", fontSize: FontSize.fontSizeBig),
          VerticalSpacing.small,
          UIHelper.textHelper(
              text: item.description ?? "N/A",
              maxLines: 3,
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
