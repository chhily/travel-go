import 'package:flutter/material.dart';
import 'package:travel_go/constant/app_size.dart';
import 'package:travel_go/widget/image_helper.dart';
import 'package:travel_go/widget/image_viewer.dart';

class ReceiverImageWidget extends StatelessWidget {
  final String imageUrl;
  const ReceiverImageWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
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
          child: NetworkImageHelper(imageUrl: imageUrl),
        ),
      ),
    );
  }
}
