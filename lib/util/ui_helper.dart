import 'package:flutter/material.dart';
import 'package:travel_go/constant/app_size.dart';

import '../constant/app_color.dart';

class UIHelper {
  UIHelper._();

  static Text textHelper({
    required String text,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    double? fontSize,
    Color? textColor,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontWeight: fontWeight ?? FontWeight.normal,
        fontSize: fontSize ?? FontSize.fontSizeRegular,
        color: textColor ?? AppColors.primary,
      ),
    );
  }
}
