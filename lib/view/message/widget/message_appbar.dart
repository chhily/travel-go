import 'package:flutter/material.dart';
import 'package:travel_go/constant/app_size.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/constant/app_url.dart';
import 'package:travel_go/util/ui_helper.dart';

class MessageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String imgUrl;
  final String username;
  const MessageAppBar(
      {super.key, required this.imgUrl, required this.username});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      title: Row(
        children: [
          UIHelper.imageAvatarHelper("$imgUrl?token=${AppUrl.senderToken}",
              size: 36),
          HorizontalSpacing.regular,
          UIHelper.textHelper(
              text: username,
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
