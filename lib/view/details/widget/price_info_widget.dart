import 'package:flutter/material.dart';
import 'package:travel_go/constant/app_color.dart';
import 'package:travel_go/constant/app_size.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/util/ui_helper.dart';

class PriceAndBookingWidget extends StatelessWidget {
  const PriceAndBookingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UIHelper.textHelper(
                  text: "Price", textColor: AppColors.textSecondary),
              VerticalSpacing.medium,
              UIHelper.currencyText(
                  price: 10000,
                  currency: "USD",
                  fontSize: FontSize.fontSizeTitle,
                  isSlash: true,
                  slashInfo: "Day")
            ],
          ),
        ),
        UIHelper.buttonHelper(
            onPressed: () {},
            buttonText: "Book Now",
            minimumSize: const Size(100, 50))
      ],
    );
  }
}
