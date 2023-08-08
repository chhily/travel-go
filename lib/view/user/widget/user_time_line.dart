import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/util/ui_helper.dart';
import 'package:travel_go/view/content/widget/image_content.dart';

import '../../content/widget/text_content.dart';

class UserTimeLineWidget extends StatefulWidget {
  const UserTimeLineWidget({super.key});

  @override
  State<UserTimeLineWidget> createState() => _UserTimeLineWidgetState();
}

class _UserTimeLineWidgetState extends State<UserTimeLineWidget>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  int selectedIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 4, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  List<Widget> tabs = [
    Tab(
      child: UIHelper.textHelper(text: "Post"),
    ),
    Tab(
      child: UIHelper.textHelper(text: "Post & Replies"),
    ),
    Tab(
      child: UIHelper.textHelper(text: "Media"),
    ),
    Tab(
      child: UIHelper.textHelper(text: "Likes"),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 40,
            width: MediaQuery.of(context).size.width,
            child: TabBar(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              indicatorPadding: EdgeInsets.zero,
              indicatorSize: TabBarIndicatorSize.tab,
              isScrollable: true,
              controller: tabController,
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                  tabController.animateTo(index);
                });
              },
              tabs: tabs,
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: Padding(
              padding: AppGap.regularGap,
              child: IndexedStack(
                index: selectedIndex,
                children: [
                  _contentPost(),
                  const Icon(FontAwesomeIcons.comment),
                  _contentPost(),
                  const Icon(FontAwesomeIcons.thumbsUp),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _contentPost() {
    return ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          if (index.isEven) {
            return const TextContentWidget();
          } else {
            return ImageContentWidget(
              index: index,
            );
          }
        },
        separatorBuilder: (context, index) => VerticalSpacing.regular,
        itemCount: 10);
  }
}
