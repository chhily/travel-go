import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/util/app_helper.dart';
import 'package:travel_go/view/content/widget/image_content.dart';

class ContentPage extends StatelessWidget {
  const ContentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppGap.regularGap,
      child: Column(
        children: [
          SvgPicture.asset(
            AppHelper.svgHelper("travel_go_banner"),
          ),
          const ImageContentWidget()
        ],
      ),
    );
  }
}
