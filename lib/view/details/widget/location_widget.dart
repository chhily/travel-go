import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_go/constant/app_color.dart';
import 'package:travel_go/constant/app_size.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/util/ui_helper.dart';

class LocationMapWidget extends StatelessWidget {
  const LocationMapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            UIHelper.textHelper(
                text: "Location",
                fontSize: FontSize.fontSizeTitle,
                fontWeight: FontWeight.bold,
                textColor: AppColors.primary),
            HorizontalSpacing.small,
            const Icon(FontAwesomeIcons.locationDot, size: 20)
          ],
        ),
        VerticalSpacing.regular,
        Container(
          height: MediaQuery.of(context).size.height * 0.35,
          decoration: BoxDecoration(
              color: AppColors.contentColor.withOpacity(0.5),
              borderRadius: AppRadius.regular),
          child: const Center(
            child: CircleAvatar(
              radius: 40,
              backgroundColor: AppColors.primary,
              child: Icon(FontAwesomeIcons.map, size: 24),
            ),
          ),
        )
      ],
    );
  }
}
