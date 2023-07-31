import 'package:flutter/cupertino.dart';

class HorizontalSpacing {
  HorizontalSpacing._();
  static const small = SizedBox(width: 4);
  static const medium = SizedBox(width: 8);
  static const regular = SizedBox(width: 12);
  static const big = SizedBox(width: 16);
  static const huge = SizedBox(width: 20);
}

class VerticalSpacing {
  VerticalSpacing._();
  static const small = SizedBox(height: 4);
  static const medium = SizedBox(height: 8);
  static const regular = SizedBox(height: 12);
  static const big = SizedBox(height: 16);
  static const huge = SizedBox(height: 20);
}

class AppGap {
  AppGap._();
  static const smallGap = EdgeInsets.symmetric(horizontal: 8, vertical: 4);
  static const mediumGap = EdgeInsets.symmetric(horizontal: 12, vertical: 8);
  static const regularGap = EdgeInsets.symmetric(horizontal: 16, vertical: 12);
  static const bigGap = EdgeInsets.symmetric(horizontal: 20, vertical: 16);
  static const hugeGap = EdgeInsets.symmetric(horizontal: 24, vertical: 20);
}
