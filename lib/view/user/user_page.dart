import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_go/constant/app_size.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/util/ui_helper.dart';
import 'package:travel_go/view/user/widget/menu.dart';

import '../../constant/app_color.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Stack(
            children: [
              // buildProfileImg(context: context, imgUrl: MockData.userCoverImg),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.3,
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: UIHelper.cardHelper(
                      elevation: 0.5,
                      colors: AppColors.white.withOpacity(0.5),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          VerticalSpacing.regular,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              UIHelper.textHelper(
                                  text: "Bessie Cooper",
                                  fontSize: FontSize.fontSizeTitle,
                                  fontWeight: FontWeight.bold),
                              HorizontalSpacing.medium,
                              const Icon(
                                FontAwesomeIcons.circleCheck,
                                color: AppColors.secondary,
                                size: 16,
                              )
                            ],
                          ),
                          const Expanded(
                            child: UserMenuWidget(),
                          ),
                          UIHelper.textHelper(text: "Version 1.0.0"),
                          VerticalSpacing.regular,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
