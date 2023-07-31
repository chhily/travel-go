import 'package:flutter/material.dart';

class UIHelper {
  static Text textHelper({required String text, TextAlign? textAlign, FontWeight? fontWeight}) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontWeight: fontWeight,

      ),
    );
  }
}
