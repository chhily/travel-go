import 'package:flutter/material.dart';
import 'package:travel_go/constant/app_color.dart';
import 'package:travel_go/constant/app_size.dart';
import 'package:travel_go/util/ui_helper.dart';
class TabWidget extends StatelessWidget {
  final TabController? controller;
  final TabBarView tabBarView;
  const TabWidget({super.key, this.controller, required this.tabBarView});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            height: 36,
            decoration: BoxDecoration(
              borderRadius: AppRadius.regular,
              color: AppColors.contentColor,
            ),
            child: TabBar(
              splashBorderRadius: AppRadius.regular,
              indicatorSize: TabBarIndicatorSize.tab,
              padding: EdgeInsets.zero,
              indicator: BoxDecoration(
                  color: AppColors.white,
                  border: Border.all(color: AppColors.contentColor),
                  borderRadius: AppRadius.regular),
              tabs: [
                Tab(
                  icon: UIHelper.textHelper(text: "Users"),
                ),
                Tab(icon: UIHelper.textHelper(text: "Stores")),
              ],
            ),
          ),
          Expanded(child: tabBarView)
        ],
      ),
    );
  }
}
