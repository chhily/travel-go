import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:travel_go/constant/app_url.dart';

import '../constant/app_color.dart';

class ImageViewer extends StatelessWidget {
  final String imageUrl;
  const ImageViewer({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height,
          maxWidth: MediaQuery.of(context).size.width),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          PhotoView(
            imageProvider:
                NetworkImage("$imageUrl?token=${AppUrl.senderToken}"),
            filterQuality: FilterQuality.high,
            minScale: PhotoViewComputedScale.contained * 1,
            heroAttributes: PhotoViewHeroAttributes(
              tag: imageUrl,
            ),
            loadingBuilder: (context, event) {
              return Container(
                color: AppColors.white,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
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
          ),
          SafeArea(
              child: IconButton(
                  onPressed: () {
                    Navigator.maybePop(context);
                  },
                  icon: CircleAvatar(
                    backgroundColor: AppColors.primary.withOpacity(0.5),
                    child: const Icon(
                      FontAwesomeIcons.xmark,
                      color: AppColors.white,
                    ),
                  )))
        ],
      ),
    );
  }
}
