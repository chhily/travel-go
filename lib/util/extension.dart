import 'package:flutter/material.dart';

extension TravelGoExtension on BuildContext {
  void hideKeyboard() => FocusScope.of(this).unfocus();
  Size get mediaQuerySize => MediaQuery.of(this).size;
}
