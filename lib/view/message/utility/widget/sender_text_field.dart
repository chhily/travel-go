import 'package:flutter/material.dart';
import 'package:travel_go/constant/app_color.dart';
import 'package:travel_go/constant/app_size.dart';

class SenderTextFieldWidget extends StatelessWidget {
  const SenderTextFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: TextEditingController(),
      textAlign: TextAlign.start,
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
