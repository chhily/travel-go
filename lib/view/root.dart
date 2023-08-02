import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_go/constant/app_color.dart';
import 'package:travel_go/view/home/home.dart';
import 'package:travel_go/widget/bottom_bar.dart';

import 'search/explore_page.dart';

class TravelGoRoot extends StatefulWidget {
  const TravelGoRoot({super.key});

  @override
  State<TravelGoRoot> createState() => TravelGoRootState();
}

class TravelGoRootState extends State<TravelGoRoot>
    with SingleTickerProviderStateMixin {
  late int currentPage;
  late TabController tabController;
  final List<Color> colors = [
    AppColors.white,
    AppColors.white,
    AppColors.white,
    AppColors.white,
  ];

  final List<IconData> icons = [
    FontAwesomeIcons.house,
    FontAwesomeIcons.solidCompass,
    FontAwesomeIcons.solidBell,
    FontAwesomeIcons.solidUser,
  ];

  @override
  void initState() {
    super.initState();
    currentPage = 0;
    tabController = TabController(length: icons.length, vsync: this);
    tabController.animation!.addListener(
      () {
        final value = tabController.animation!.value.round();
        if (value != currentPage && mounted) {
          changePage(value);
        }
      },
    );
  }

  void changePage(int newPage) {
    setState(() {
      currentPage = newPage;
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   bottom: PreferredSize(
      //     preferredSize: Size.fromHeight(0),
      //     child: SizedBox(),
      //   ),
      // ),
      body: BottomBar(
        icons: icons,
        currentPage: currentPage,
        tabController: tabController,
        colors: colors,
        unselectedColor: AppColors.textSecondary,
        barColor: AppColors.primary,
        start: 10,
        end: 2,
        child: TabBarView(
          controller: tabController,
          dragStartBehavior: DragStartBehavior.down,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            SafeArea(child: HomePage()),
            SearchPage(),
            HomePage(),
            HomePage(),
          ],
        ),
      ),
    );
  }
}
