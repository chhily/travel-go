import 'package:flutter/material.dart';
import 'package:travel_go/constant/app_color.dart';
import 'package:travel_go/constant/app_size.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/util/ui_helper.dart';
import 'package:travel_go/view/notification/widget/activity_list.dart';
import 'package:travel_go/view/notification/widget/notification_list.dart';

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
                      text: "Notifications",
                      fontSize: FontSize.fontSizeHuge,
                      fontWeight: FontWeight.bold),
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
          Expanded(
            child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    VerticalSpacing.regular,
                    Container(
                      height: 36,
                      decoration: BoxDecoration(
                        borderRadius: AppRadius.regular,
                        color: AppColors.contentColor,
                      ),
                      child: TabBar(
                        indicatorSize: TabBarIndicatorSize.tab,
                        padding: EdgeInsets.zero,
                        indicator: BoxDecoration(
                            color: AppColors.white,
                            border: Border.all(color: AppColors.contentColor),
                            borderRadius: AppRadius.regular),
                        tabs: [
                          Tab(
                            icon: UIHelper.textHelper(text: "Notifications"),
                          ),
                          Tab(icon: UIHelper.textHelper(text: "Activity")),
                        ],
                      ),
                    ),
                    VerticalSpacing.regular,
                    const Expanded(
                      child: TabBarView(
                        children: [
                          NotificationListWidget(),
                          ActivityListWidget(),
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
