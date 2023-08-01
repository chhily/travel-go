import 'package:flutter/material.dart';
import 'package:travel_go/util/ui_helper.dart';

import '../../../constant/app_color.dart';

class ChoiceChipWidget extends StatelessWidget {
  final void Function(bool selected, int index) onSelected;
  final int? valueSelected;
  const ChoiceChipWidget(
      {super.key, required this.onSelected, required this.valueSelected});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.start,
      spacing: 4,
      children: List<Widget>.generate(
        7,
        (int index) {
          return ChoiceChip(
            selectedColor: AppColors.secondary,
            side: const BorderSide(color: AppColors.contentColor),
            label: UIHelper.textHelper(
                text: 'Item ${index + 1}',
                textColor: valueSelected == index
                    ? AppColors.white
                    : AppColors.textPrimary),
            selected: valueSelected == index,
            onSelected: (value) {
              onSelected(value, index);
            },
          );
        },
      ).toList(),
    );
  }
}
