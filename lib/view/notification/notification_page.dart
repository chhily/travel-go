import 'package:flutter/material.dart';
import 'package:travel_go/constant/app_color.dart';
import 'package:travel_go/constant/app_size.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/util/ui_helper.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppGap.regularGap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UIHelper.textHelper(
                      text: "Notification", fontSize: FontSize.fontSizeHuge),
                  VerticalSpacing.regular,
                  UIHelper.textHelper(
                      text: "You always get the latest news",
                      textColor: AppColors.textSecondary),
                ],
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: AppColors.primary)),
                child: UIHelper.imageAvatarHelper(
                    "https://i.pinimg.com/564x/4b/12/d0/4b12d0489be1afaf835cca152ef186e0.jpg"),
              ),
            ],
          ),
          const Expanded(
            child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    VerticalSpacing.regular,
                    TabBar(
                      tabs: [
                        Tab(icon: Icon(Icons.directions_car)),
                        Tab(icon: Icon(Icons.directions_transit)),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          Icon(Icons.directions_car),
                          Icon(Icons.directions_transit),
                        ],
                      ),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
