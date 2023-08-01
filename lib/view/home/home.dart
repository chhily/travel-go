import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/util/ui_helper.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: AppGap.regularGap,
      children: [
        Row(
          children: [
            Row(
              children: [
                const Icon(FontAwesomeIcons.locationPin),
                HorizontalSpacing.regular,
                UIHelper.textHelper(text: "Location")
              ],
            ),
            const Spacer(),
            const CircleAvatar(
              radius: 25,
            )
          ],
        )
      ],
    );
  }
}
