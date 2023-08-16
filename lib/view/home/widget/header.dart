import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_go/constant/app_color.dart';
import 'package:travel_go/constant/app_size.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/constant/app_url.dart';
import 'package:travel_go/util/ui_helper.dart';
import 'package:travel_go/view/contact/user_chat.dart';
import 'package:travel_go/view/message/message_page.dart';

import '../../contact/user/contact_page.dart';

class HomeHeaderWidget extends StatelessWidget {
  final Stream<String?>? streamController;
  const HomeHeaderWidget({super.key, this.streamController});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: AppColors.primary)),
              child: UIHelper.imageAvatarHelper(
                  "https://i.pinimg.com/564x/4b/12/d0/4b12d0489be1afaf835cca152ef186e0.jpg"),
            ),
            // Row(
            //   children: [
            //     const Icon(FontAwesomeIcons.locationDot),
            //     HorizontalSpacing.regular,
            //     StreamBuilder<String?>(
            //         stream: streamController,
            //         builder: (context, myAddressValue) {
            //           return UIHelper.textHelper(
            //               text: myAddressValue.data ?? "N/A");
            //         })
            //   ],
            // ),
            const Spacer(),
            // Container(
            //   padding: const EdgeInsets.all(2),
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(50),
            //       border: Border.all(color: AppColors.primary)),
            //   child: UIHelper.imageAvatarHelper(
            //       "https://i.pinimg.com/564x/4b/12/d0/4b12d0489be1afaf835cca152ef186e0.jpg"),
            // ),
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserContactPage(),
                    ));
              },
              icon: const Icon(
                FontAwesomeIcons.heart,
                size: 20,
              ),
            ),

            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserChatPage(),
                    ));
              },
              icon: const Icon(
                FontAwesomeIcons.comment,
                size: 20,
              ),
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
      ],
    );
  }
}
