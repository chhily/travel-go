import 'package:flutter/material.dart';
import 'package:travel_go/constant/app_size.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/constant/app_url.dart';
import 'package:travel_go/model/receiver_model.dart';
import 'package:travel_go/model/receiver_store.dart';
import 'package:travel_go/util/ui_helper.dart';

class MessageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ReceiverModel? receiverUserInfo;
  final ReceiverStoreModel? receiverStoreInfo;

  const MessageAppBar(
      {super.key, this.receiverUserInfo, this.receiverStoreInfo});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      title: Row(
        children: [
          UIHelper.imageAvatarHelper(
              "${receiverStoreInfo?.photoUrl ?? receiverUserInfo?.photoUrl}"
              "?token=${AppUrl.senderToken}",
              size: 36),
          HorizontalSpacing.regular,
          UIHelper.textHelper(
              text: receiverStoreInfo?.name ??
                  receiverUserInfo?.fullName ??
                  "N/A",
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
