import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_go/constant/app_size.dart';
import 'package:travel_go/constant/app_spacing.dart';

class UserActionButton extends StatelessWidget {
  const UserActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          borderRadius: AppRadius.regular,
          onTap: () {},
          child: const Icon(
            FontAwesomeIcons.heart,
            size: 16,
          ),
        ),
        HorizontalSpacing.regular,
        InkWell(
          borderRadius: AppRadius.regular,
          onTap: () {},
          child: const Icon(
            FontAwesomeIcons.comment,
            size: 16,
          ),
        ),
        HorizontalSpacing.regular,
        InkWell(
          borderRadius: AppRadius.regular,
          onTap: () {},
          child: const Icon(
            FontAwesomeIcons.repeat,
            size: 16,
          ),
        ),
        HorizontalSpacing.regular,
        InkWell(
          borderRadius: AppRadius.regular,
          onTap: () {},
          child: const Icon(
            FontAwesomeIcons.share,
            size: 16,
          ),
        ),
      ],
    );
  }
}
