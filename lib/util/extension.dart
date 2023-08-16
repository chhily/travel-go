import 'package:flutter/material.dart';

extension TravelGoExtension on BuildContext {
  void hideKeyboard() => FocusScope.of(this).unfocus();
  Size get mediaQuerySize => MediaQuery.of(this).size;
}

extension MessageExtension on bool {
  BorderRadius get messageRadius {
    if (this) {
      return const BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10));
    } else {
      return const BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
          bottomRight: Radius.circular(10));
    }
  }
}
