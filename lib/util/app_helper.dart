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

  static num generateRandomNumber({int? maxNum}) {
    Random random = Random();

    num number = 0;

    for (int i = 0; i < 50; i++) {
      number += random.nextInt(maxNum ?? 9);
    }
    return number;
  }

  static String dateTimeFormatter({DateTime? dateTime}) {
    if (dateTime == null) return "N/A";
    final result = DateFormat('dd MMM yyyy hh a').format(dateTime.toLocal());
    return result;
  }

  static String dateFormatter({DateTime? dateTime}) {
    if (dateTime == null) return "N/A";
    final result = DateFormat('dd MMM yyyy').format(dateTime.toLocal());
    return result;
  }

  static String formatNumber({num? number}) {
    if (number == null) return "N/A";
    return NumberFormat.compact().format(number);
  }

  static DateTime generateRandomDateTime(
      DateTime startDateTime, DateTime endDateTime) {
    Random random = Random();
    int randomDays =
        random.nextInt((endDateTime.difference(startDateTime).inDays) + 1);
    return startDateTime.add(Duration(days: randomDays));
  }

  static String generateRandomString(int maxWords) {
    Random random = Random();
    List<String> words = [];
    for (int i = 0; i < maxWords; i++) {
      int wordLength = random.nextInt(10) + 3;
      String word = '';
      for (int j = 0; j < wordLength; j++) {
        int character = random.nextInt(26) + 97;
        word += String.fromCharCode(character);
      }
      words.add(word);
    }
    return words.join(", ");
  }

  static String svgHelper(String svg) {
    return "assets/svg/$svg.svg";
  }
}
