import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constant/app_color.dart';
import '../constant/app_url.dart';

class NetworkImageHelper extends StatelessWidget {
  final String? imageUrl;
  final double? height;
  final BoxFit? fit;
  final double? width;

  const NetworkImageHelper(
      {super.key, required this.imageUrl, this.height, this.fit, this.width});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: CachedNetworkImage(
        imageUrl:
            imageUrl == null ? "" : "$imageUrl?token=${AppUrl.senderToken}",
        height: height,
        width: width,
        filterQuality: FilterQuality.high,
        fadeInCurve: Curves.slowMiddle,
        fit: fit,
        placeholder: (context, url) {
          return SizedBox(
            height: height,
            child: const Center(
              child: SizedBox(
                height: 12,
                width: 12,
                child: CircularProgressIndicator.adaptive(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppColors.primary),
                  strokeWidth: 1,
                ),
              ),
            ),
          );
        },
        errorWidget: (context, url, error) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: const Icon(FontAwesomeIcons.info),
          );
        },
      ),
    );
  }
}
