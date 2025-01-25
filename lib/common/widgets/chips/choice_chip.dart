import 'package:flutter/material.dart';
import 'package:gear_share_project/utils/constants/colors.dart';

class KChoiceChip extends StatelessWidget {
  const KChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    this.onSelected,
  });

  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
        label: Text(text),
        selected: selected,
        onSelected: (value) {},
        labelStyle: TextStyle(color: selected ? KColors.white : null),
      ),
    );
  }
}
