import 'package:flutter/material.dart';
import 'package:travel_go/constant/app_size.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/mock/mock_data.dart';
import 'package:travel_go/util/ui_helper.dart';

class CategoryHighlightWidget extends StatelessWidget {
  final List<ItemObject> itemList;
  const CategoryHighlightWidget({super.key, required this.itemList});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 10,
      spacing: 10,
      alignment: WrapAlignment.start,
      children: List.generate(
        itemList.length,
        (index) {
          final itemValue = itemList.elementAt(index);
          return _buildCategoryWidget(
              imgUrl: itemValue.image ?? "",
              tile: itemValue.title ?? "",
              available: index,
              context: context);
        },
      ).toList(),
    );
  }

  Widget _buildCategoryWidget(
      {required String imgUrl,
      required String tile,
      required num available,
      required BuildContext context}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.43,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          UIHelper.cacheImageHelper(image: imgUrl, width: 40, height: 40),
          HorizontalSpacing.regular,
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UIHelper.textHelper(
                  text: tile,
                  fontSize: FontSize.fontSizeBig,
                  fontWeight: FontWeight.bold),
              UIHelper.textHelper(
                  text: "Available: $available",
                  fontSize: FontSize.fontSizeMedium)
            ],
          ),
        ],
      ),
    );
  }
}
