import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_go/constant/app_size.dart';
import 'package:travel_go/util/app_helper.dart';

import '../constant/app_color.dart';

class UIHelper {
  UIHelper._();

  static Text textHelper({
    required String text,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    double? fontSize,
    Color? textColor,
    int? maxLines,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
        fontWeight: fontWeight ?? FontWeight.normal,
        fontSize: fontSize ?? FontSize.fontSizeRegular,
        color: textColor ?? AppColors.primary,
      ),
    );
  }

  static Text currencyText({
    required num price,
    required String currency,
    TextAlign? textAlign,
    FontWeight? fontWeight,
    double? fontSize,
    Color? textColor,
    String? slashInfo,
    bool? isSlash = false,
  }) {
    return Text(
      isSlash == true
          ? "$currency${AppHelper.priceFormatter(price)} / $slashInfo"
          : currency + AppHelper.priceFormatter(price),
      textAlign: textAlign,
      style: TextStyle(
        fontWeight: fontWeight ?? FontWeight.normal,
        fontSize: fontSize ?? FontSize.fontSizeRegular,
        color: textColor ?? AppColors.primary,
      ),
    );
  }

  static Card cardHelper(
      {required Widget child, double? elevation, Color? colors}) {
    return Card(
      elevation: elevation ?? 0,
      color: colors ?? AppColors.white,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.regular,
      ),
      child: child,
    );
  }

  static Widget imageAvatarHelper(String imageUrl,
      {double? width, double? height}) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width ?? 50,
      height: height ?? 50,
      imageBuilder: (context, imageProvider) {
        return CircleAvatar(
          backgroundColor: AppColors.contentColor,
          backgroundImage: imageProvider,
        );
      },
      placeholder: (context, url) {
        return const Center(
          child: SizedBox(
            height: 12,
            width: 12,
            child: CircularProgressIndicator.adaptive(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              strokeWidth: 1,
            ),
          ),
        );
      },
      errorWidget: (context, url, error) {
        return CircleAvatar(
          backgroundColor: AppColors.primary,
          child: Image.network(
            url,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                FontAwesomeIcons.user,
                color: AppColors.secondary,
              );
            },
          ),
        );
      },
    );
  }

  static Widget cacheImageHelper(
      {required String image,
      double? width,
      double? height,
      Widget? child,
      BoxFit? fit,
      Color? colorDecoration,
      double opacity = 1.0,
      BorderRadiusGeometry? borderRadius}) {
    return CachedNetworkImage(
      imageUrl: image,
      imageBuilder: (context, imageProvider) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: colorDecoration,
            borderRadius: borderRadius ?? AppRadius.regular,
            image: DecorationImage(
                image: imageProvider,
                fit: fit ?? BoxFit.cover,
                opacity: opacity),
          ),
          child: child,
        );
      },
      placeholder: (context, url) {
        return SizedBox(
          width: width,
          height: height,
          child: const Center(
            child: SizedBox(
              height: 12,
              width: 12,
              child: CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                strokeWidth: 1,
              ),
            ),
          ),
        );
      },
      errorWidget: (context, url, error) => const Icon(Icons.error, size: 40),
    );
  }

  static loadingDialogHelper(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: const Dialog(
            insetPadding: EdgeInsets.zero,
            backgroundColor: Colors.black45,
            clipBehavior: Clip.antiAlias,
            child: Center(
              child: SizedBox(
                height: 12,
                width: 12,
                child: CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                  strokeWidth: 1,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static OutlinedButton outlineButton(
      {required void Function()? onPressed,
      required String buttonText,
      Widget? childWidget,
      Color? buttonColor,
      Color? foregroundColor,
      BorderSide? side,
      OutlinedBorder? shape}) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
          elevation: 0,
          backgroundColor: buttonColor,
          foregroundColor: foregroundColor,
          side: side,
          shape: shape),
      child: childWidget ??
          Container(
            child: textHelper(text: buttonText),
          ),
    );
  }
}
