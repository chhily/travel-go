import 'dart:math';

import 'package:intl/intl.dart';

class AppHelper {
  AppHelper._();

  static String assetsString(
      {required String image, required dynamic fileEXT}) {
    return "assets/images/$image.${fileEXT.toString()}";
  }

  static String priceFormatter(num price) {
    final numberFormat = NumberFormat('#,###,###.##');
    return numberFormat.format(price);
  }

  static num generateRandomNumber() {
    Random random = Random();

    num number = 0;

    for (int i = 0; i < 50; i++) {
      number += random.nextInt(9);
    }
    return number;
  }
}
