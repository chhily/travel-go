import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_go/constant/app_color.dart';
import 'package:travel_go/constant/app_size.dart';
import 'package:travel_go/constant/app_spacing.dart';
import 'package:travel_go/util/app_helper.dart';

class FollowerAndFollowingWidget extends StatelessWidget {
  const FollowerAndFollowingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        text(title: 214234325, subtitle: "Following"),
        HorizontalSpacing.medium,
        text(title: 12143, subtitle: "Follower"),
      ],
    );
  }

  RichText text({required num title, required String subtitle}) {
    TextStyle titleStyle = GoogleFonts.openSans(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.bold,
        fontSize: FontSize.fontSizeRegular);
    TextStyle subStyle = GoogleFonts.openSans(
        color: AppColors.textPrimary,
        fontWeight: FontWeight.normal,
        fontSize: FontSize.fontSizeRegular);
    return RichText(
      text: TextSpan(
        text: AppHelper.formatNumber(number: title),
        style: titleStyle,
        children: [
          TextSpan(text: " $subtitle", style: subStyle),
        ],
      ),
    );
  }
}
