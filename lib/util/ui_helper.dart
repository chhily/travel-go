import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_go/constant/app_size.dart';
import 'package:travel_go/util/app_helper.dart';

import '../constant/app_color.dart';
import '../constant/app_spacing.dart';

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
          overflow: TextOverflow.ellipsis),
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
      {double? size, double? radius}) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: size ?? 50,
      height: size ?? 50,
      imageBuilder: (context, imageProvider) {
        return CircleAvatar(
          radius: radius ?? size ?? 50 / 2,
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
                FontAwesomeIcons.userNinja,
                color: AppColors.white,
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
      width: width,
      height: height,
      imageBuilder: (context, imageProvider) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: height ?? double.infinity,
            maxWidth: width ?? double.infinity,
          ),
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
      errorWidget: (context, url, error) => Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              color: AppColors.contentColor.withOpacity(0.5),
              borderRadius: borderRadius ?? AppRadius.regular),
          child: const Icon(Icons.error, size: 40)),
    );
  }

  static loadingDialogHelper(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      useSafeArea: false,
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: const Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(0))),
            insetPadding: EdgeInsets.zero,
            backgroundColor: Colors.black12,
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

  static snackBarHelper({required BuildContext context, String? snackMessage}) {
    final snackBar = SnackBar(
      backgroundColor: AppColors.primary,
      // behavior: SnackBarBehavior.floating,
      content: Row(
        children: [
          const Icon(
            FontAwesomeIcons.info,
            color: AppColors.white,
          ),
          HorizontalSpacing.regular,
          textHelper(
            text: snackMessage ?? "Yay!",
            textColor: AppColors.white,
          ),
        ],
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static OutlinedButton outlineButton(
      {required void Function()? onPressed,
      String? buttonText,
      Widget? childWidget,
      Color? buttonColor,
      Color? foregroundColor,
      Color? textColor,
      BorderSide? side,
      double? fontSize,
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
          textHelper(
              text: buttonText ?? "",
              textColor: textColor,
              fontSize: fontSize,
              fontWeight: FontWeight.bold),
    );
  }

  static Widget linkButtonHelper(
      {Widget? child, String? text, double? fontSize}) {
    return InkWell(
      onTap: () {},
      child: child ??
          textHelper(
              text: text ?? "N/A",
              fontSize: fontSize,
              textColor: AppColors.secondary),
    );
  }

  static ElevatedButton buttonHelper(
      {required void Function()? onPressed,
      required String buttonText,
      FontWeight? fontWeight,
      Color? textColor,
      Color? buttonColor,
      Size? minimumSize,
      double? textSize,
      OutlinedBorder? shape}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          minimumSize: minimumSize,
          elevation: 0,
          backgroundColor: buttonColor,
          shape: shape),
      child: Text(buttonText,
          style: TextStyle(
              fontWeight: fontWeight ?? FontWeight.bold,
              color: textColor,
              fontSize: textSize ?? FontSize.fontSizeRegular)),
    );
  }
}
