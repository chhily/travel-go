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

}


