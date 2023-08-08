import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/util/app_helper.dart';
import 'package:travel_go/view/content/widget/image_content.dart';
import 'package:travel_go/view/content/widget/text_content.dart';

import '../../widget/bottom_bar.dart';

class ContentPage extends StatelessWidget {
  const ContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: InheritedDataProvider.of(context).scrollController,
      padding: AppGap.regularGap,
      children: [
        SvgPicture.asset(
          AppHelper.svgHelper("travel_go_banner"),
        ),
        ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
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
            itemCount: 10),
        const SizedBox(height: 100)
      ],
    );
  }
}
