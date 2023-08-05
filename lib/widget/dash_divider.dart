import 'package:flutter/material.dart';

import '../constant/app_color.dart';
import '../constant/app_spacing.dart';

class DashDivider extends StatelessWidget {
  const DashDivider(
      {Key? key, this.height = 1, this.color = AppColors.primary, this.gap})
      : super(key: key);
  final double height;
  final EdgeInsetsGeometry? gap;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: gap ?? const EdgeInsets.symmetric(vertical: 12, horizontal: 2),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final boxWidth = constraints.constrainWidth();
          const dashWidth = 5.0;
          final dashHeight = height;
          final dashCount = (boxWidth / (2 * dashWidth)).floor();
          return Flex(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            direction: Axis.horizontal,
            children: List.generate(dashCount, (_) {
              return SizedBox(
                width: dashWidth,
                height: dashHeight,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: color),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
