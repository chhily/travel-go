class AppHelper {
  AppHelper._();

  static String assetsString(
      {required String image, required dynamic fileEXT}) {
    return "assets/images/$image.${fileEXT.toString()}";
  }


}
