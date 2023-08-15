import 'package:flutter/material.dart';

extension TravelGoExtension on BuildContext {
  void hideKeyboard() => FocusScope.of(this).unfocus();
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}
