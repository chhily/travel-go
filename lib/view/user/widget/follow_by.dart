import 'package:flutter/material.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/mock/mock_data.dart';
import 'package:travel_go/util/ui_helper.dart';

class FollowByWidget extends StatelessWidget {
  const FollowByWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < 3; i++)
              Align(
                widthFactor: 0.5,
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(
                      MockData.countryImgUrl[i],
                    ),
                  ),
                ),
              )
          ],
        ),
        HorizontalSpacing.big,
        Flexible(
            child: UIHelper.textHelper(
                text: "Follow by ${MockData.country.join(", ")}...")),
      ],
    );
  }
}
