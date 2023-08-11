import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_go/constant/app_size.dart';

class ImagePreviewWidget extends StatelessWidget {
  final File file;
  final void Function()? onPressed;
  const ImagePreviewWidget({super.key, required this.file, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Container(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.25),
            decoration: BoxDecoration(
                borderRadius: AppRadius.regular,
                image: DecorationImage(
                  image: FileImage(file),
                )),
          ),
          IconButton(
            onPressed: onPressed,
            icon: const Icon(FontAwesomeIcons.circleXmark),
          ),
        ],
      ),
    );
  }
}
