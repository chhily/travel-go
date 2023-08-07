import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/mock/mock_data.dart';
import 'package:travel_go/util/ui_helper.dart';

import '../../../constant/app_color.dart';

class UserProfileWidget extends StatelessWidget {
  const UserProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Stack(
        children: [
          UIHelper.cacheImageHelper(
              image: MockData.bgImage,
              borderRadius: BorderRadius.circular(0),
              height: MediaQuery.of(context).size.height * 0.23),
          Positioned(
            bottom: 0,
            left: 16,
            right: 16,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: AppColors.white, width: 4)),
                  child: UIHelper.imageAvatarHelper(MockData.userCoverImg,
                      width: 75, height: 75),
                ),
                const Spacer(),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.primary,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: const Icon(FontAwesomeIcons.message,
                            color: AppColors.white, size: 16),
                      ),
                    ),
                    HorizontalSpacing.regular,
                    UIHelper.outlineButton(
                        onPressed: () {},
                        buttonText: "Edit",
                        textColor: AppColors.white,
                        buttonColor: AppColors.primary)
                  ],
                )
              ],
            ),
          ),
          // Positioned(
          //   bottom: 28,
          //   right: 16,
          //   child: Row(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       CircleAvatar(
          //         backgroundColor: AppColors.primary,
          //         child: IconButton(
          //           padding: EdgeInsets.zero,
          //           onPressed: () {},
          //           icon: const Icon(FontAwesomeIcons.message,
          //               color: AppColors.white, size: 20),
          //         ),
          //       ),
          //       HorizontalSpacing.regular,
          //       UIHelper.outlineButton(
          //           onPressed: () {},
          //           buttonText: "Follow",
          //           textColor: AppColors.white,
          //           buttonColor: AppColors.primary)
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
}
