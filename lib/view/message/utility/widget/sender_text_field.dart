import 'package:flutter/material.dart';
import 'package:travel_go/constant/app_color.dart';
import 'package:travel_go/constant/app_size.dart';

class SenderTextFieldWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  const SenderTextFieldWidget({super.key, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      textAlign: TextAlign.start,
      minLines: 1,
      maxLines: 7,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          focusedBorder: OutlineInputBorder(
              borderRadius: AppRadius.big,
              borderSide: const BorderSide(color: AppColors.secondary)),
          enabledBorder: OutlineInputBorder(
              borderRadius: AppRadius.big,
              borderSide: const BorderSide(color: AppColors.primary)),
          fillColor: AppColors.white),
    );
  }
}
