import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:travel_go/constant/app_url.dart';

import '../constant/app_color.dart';

class ImageViewer extends StatelessWidget {
  final String imageUrl;
  const ImageViewer({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height,
          maxWidth: MediaQuery.of(context).size.width),
      child: PhotoView(
        imageProvider: NetworkImage("$imageUrl?token=${AppUrl.senderToken}"),
        filterQuality: FilterQuality.high,
        disableGestures: true,
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
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                  strokeWidth: 1,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
