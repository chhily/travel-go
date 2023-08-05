import 'package:flutter/material.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/util/ui_helper.dart';
import 'package:travel_go/view/details/widget/details_header.dart';
import 'package:travel_go/view/details/widget/location_widget.dart';
import 'package:travel_go/widget/dash_divider.dart';

import '../../mock/mock_data.dart';
import 'widget/price_info_widget.dart';

class ItemDetails extends StatelessWidget {
  final ItemObject? itemObject;
  const ItemDetails({super.key, this.itemObject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: AppGap.regularGap,
          children: [
            DetailsHeaderWidget(itemObject: itemObject),
            VerticalSpacing.regular,
            UIHelper.textHelper(text: itemObject?.description ?? "N/A"),
            VerticalSpacing.big,
            const LocationMapWidget(),
            VerticalSpacing.big,
            const DashDivider(),
            VerticalSpacing.big,
            const PriceAndBookingWidget(),
            VerticalSpacing.huge,
          ],
        ),
      ),
    );
  }
}
