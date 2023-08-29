import 'dart:async';

import 'package:flutter/material.dart';

class DeBouncer {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  DeBouncer({this.milliseconds = 800});

  run(VoidCallback action) {
    if (_timer != null) {
      _timer!.cancel();
    }

    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
