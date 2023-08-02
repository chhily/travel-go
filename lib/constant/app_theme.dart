import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel_go/constant/app_color.dart';
import 'package:travel_go/constant/app_size.dart';

class AppTheme {
  AppTheme._();

  static ThemeData theme(TextTheme textTheme) {
    return ThemeData(
        textTheme: GoogleFonts.openSansTextTheme(textTheme).copyWith(),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: AppColors.primary,
            textStyle: GoogleFonts.openSans(
              fontSize: FontSize.fontSizeRegular,
              color: AppColors.white,
            ),
            foregroundColor: AppColors.white,
            shape: RoundedRectangleBorder(borderRadius: AppRadius.regular),
          ),
        ),
        iconTheme: const IconThemeData(
          color: AppColors.primary,
        ),
        scaffoldBackgroundColor: AppColors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleSpacing: 0,
          titleTextStyle: GoogleFonts.openSans(
            fontSize: FontSize.fontSizeTitle,
            color: Colors.black,
          ),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light,
          ),
        ),
        iconButtonTheme: const IconButtonThemeData(
          style: ButtonStyle(
            iconColor: MaterialStatePropertyAll(AppColors.primary),
          ),
        ),
        searchBarTheme: SearchBarThemeData(
          textStyle: MaterialStateProperty.all(
            GoogleFonts.openSans(fontSize: FontSize.fontSizeRegular),
          ),
        ),
        useMaterial3: true,
        splashFactory: InkSparkle.splashFactory,
        colorScheme: ColorScheme.fromSwatch().copyWith(
            onBackground: AppColors.white,
            primary: AppColors.primary,
            secondary: AppColors.secondary,
            surfaceTint: AppColors.black,
            background: AppColors.white));
  }
}
