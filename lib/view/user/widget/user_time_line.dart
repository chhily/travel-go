import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_go/util/ui_helper.dart';

class UserTimeLineWidget extends StatelessWidget {
  const UserTimeLineWidget({super.key});

  @override
  Widget build(BuildContext context) {
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

    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          SizedBox(
            height: 40,
            width: MediaQuery.of(context).size.width,
            child: TabBar(
              padding: EdgeInsets.zero,
              indicatorPadding: EdgeInsets.zero,
              indicatorSize: TabBarIndicatorSize.tab,
              isScrollable: true,
              tabs: tabs,
            ),
          ),
          const Expanded(
            child: TabBarView(
              children: [
                Icon(FontAwesomeIcons.timeline),
                Icon(FontAwesomeIcons.comment),
                Icon(FontAwesomeIcons.medium),
                Icon(FontAwesomeIcons.thumbsUp),
              ],
            ),
          )
        ],
      ),
    );
  }
}
