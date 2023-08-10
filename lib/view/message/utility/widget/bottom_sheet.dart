import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_go/constant/app_color.dart';
import 'package:travel_go/constant/app_size.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/util/ui_helper.dart';

class ActionSheet extends StatelessWidget {
  final Function()? onPressedEdit;
  const ActionSheet({super.key, this.onPressedEdit});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(minHeight: MediaQuery.of(context).size.height * 0.20),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          buildIcon(
              onPressed: onPressedEdit,
              iconData: FontAwesomeIcons.pen,
              title: "Edit",
              textColor: AppColors.textPrimary,
              color: Colors.yellow),
          buildIcon(
              onPressed: () {},
              iconData: FontAwesomeIcons.trashCan,
              title: "Delete",
              color: Colors.redAccent),
        ],
      ),
    );
  }

  Widget buildIcon(
      {Function()? onPressed,
      required String title,
      Color? textColor,
      Color? color,
      required IconData iconData}) {
    return IconButton(
        onPressed: () {},
        icon: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(iconData, size: 20, color: color),
            HorizontalSpacing.regular,
            UIHelper.textHelper(
              text: title,
              textColor: textColor ?? color,
              fontSize: FontSize.fontSizeBig,
            ),
          ],
        ));
  }
}
