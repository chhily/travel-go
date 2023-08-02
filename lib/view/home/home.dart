import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_go/constant/app_color.dart';
import 'package:travel_go/constant/app_size.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/util/ui_helper.dart';
import 'package:travel_go/view/home/widget/choice_chip.dart';
import 'package:travel_go/view/home/widget/highlight_card.dart';

import 'widget/category_highlight.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int? valueSelected = 0;
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: AppGap.regularGap,
      children: [
        Row(
          children: [
            Row(
              children: [
                const Icon(FontAwesomeIcons.locationDot),
                HorizontalSpacing.regular,
                UIHelper.textHelper(text: "Location")
              ],
            ),
            const Spacer(),
            CircleAvatar(
              radius: 25,
              backgroundColor: AppColors.primary,
              child: UIHelper.imageAvatarHelper(
                  "https://i.pinimg.com/564x/4b/12/d0/4b12d0489be1afaf835cca152ef186e0.jpg"),
            ),
          ],
        ),
        VerticalSpacing.big,
        UIHelper.textHelper(
            text: "Wherever You GO,",
            fontSize: FontSize.fontSizeTitle,
            fontWeight: FontWeight.w600),
        UIHelper.textHelper(
            text: "It's Beautiful Place",
            fontSize: FontSize.fontSizeTitle,
            fontWeight: FontWeight.w600),
        VerticalSpacing.huge,
        ChoiceChipWidget(
          valueSelected: valueSelected,
          onSelected: (selected, index) {
            setState(
              () {
                valueSelected = selected ? index : null;
              },
            );
          },
        ),
        VerticalSpacing.huge,
        const HighlightCardWidget(),
        UIHelper.textHelper(
          text: "Category",
          fontWeight: FontWeight.bold,
          fontSize: FontSize.fontSizeBig,
        ),
        VerticalSpacing.big,
        const CategoryHighlightWidget(),
      ],
    );
  }
}
