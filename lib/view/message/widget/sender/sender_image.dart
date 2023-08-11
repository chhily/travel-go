import 'package:flutter/material.dart';
import 'package:travel_go/constant/app_size.dart';
import 'package:travel_go/widget/image_helper.dart';
import 'package:travel_go/widget/image_viewer.dart';

class SenderImageWidget extends StatelessWidget {
  final String imageUrl;
  const SenderImageWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return ImageViewer(imageUrl: imageUrl);
            },
          ));
        },
        child: Container(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.5,
              maxHeight: MediaQuery.of(context).size.height * 0.4),
          decoration: BoxDecoration(
            borderRadius: AppRadius.regular,
          ),
          child: ClipRRect(
              borderRadius: AppRadius.regular,
              child: NetworkImageHelper(imageUrl: imageUrl)),
        ),
      ),
    );
  }
}
