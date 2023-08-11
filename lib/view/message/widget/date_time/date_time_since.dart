import 'package:flutter/material.dart';

import '../../../../constant/app_color.dart';
import '../../../../constant/app_size.dart';
import '../../../../constant/app_spacing.dart';
import '../../../../util/app_helper.dart';
import '../../../../util/ui_helper.dart';

class DateTimeSinceWidget extends StatelessWidget {
  final DateTime? sinceAgo;
  const DateTimeSinceWidget({super.key, required this.sinceAgo});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.2),
          borderRadius: AppRadius.regular,
        ),
        margin: AppGap.regularGap,
        padding: AppGap.smallGap,
        child: UIHelper.textHelper(
            text: AppHelper.dayFormatter(dayAgo: sinceAgo),
            fontSize: FontSize.fontSizeBig),
      ),
    );
  }
}
