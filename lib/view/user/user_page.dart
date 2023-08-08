import 'package:flutter/material.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/util/ui_helper.dart';
import 'package:travel_go/view/user/widget/follow_by.dart';
import 'package:travel_go/view/user/widget/follower_following.dart';
import 'package:travel_go/view/user/widget/user_description.dart';
import 'package:travel_go/view/user/widget/user_profile.dart';
import 'package:travel_go/view/user/widget/user_time_line.dart';

import '../../widget/bottom_bar.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: InheritedDataProvider.of(context).scrollController,
      padding: EdgeInsets.zero,
      children: const [
        UserProfileWidget(),
        Padding(
          padding: AppGap.regularGap,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              UserDescriptionWidget(),
              VerticalSpacing.medium,
              FollowerAndFollowingWidget(),
              VerticalSpacing.medium,
              FollowByWidget(),
              VerticalSpacing.regular,
            ],
          ),
        ),
        UserTimeLineWidget(),
        SizedBox(height: 100)
      ],
    );
  }

  Widget buildProfileImg(
      {required BuildContext context, required String imgUrl}) {
    return UIHelper.cacheImageHelper(
      image: imgUrl,
      borderRadius: BorderRadius.circular(0),
      height: MediaQuery.of(context).size.height,
    );
  }
}
