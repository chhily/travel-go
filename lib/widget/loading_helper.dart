import 'package:flutter/material.dart';
import 'package:travel_go/constant/app_color.dart';

class LoadingHelper extends StatelessWidget {
  const LoadingHelper({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: AppColors.white,
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
  }
}
