import 'package:flutter/material.dart';
import 'package:travel_go/constant/app_size.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/mock/mock_data.dart';
import 'package:travel_go/util/ui_helper.dart';

class MessageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MessageAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      title: Row(
        children: [
          UIHelper.imageAvatarHelper(MockData.userCoverImg, size: 36),
          HorizontalSpacing.regular,
          UIHelper.textHelper(
              text: "Username",
              fontSize: FontSize.fontSizeBig,
              fontWeight: FontWeight.bold)
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(50.0);
}
