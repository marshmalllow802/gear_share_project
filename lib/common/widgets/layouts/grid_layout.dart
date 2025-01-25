import 'package:flutter/material.dart';
import 'package:gear_share_project/utils/constants/sizes.dart';

class KGridLayout extends StatelessWidget {
  const KGridLayout(
      {super.key,
      required this.itemCount,
      required this.itemBuilder,
      this.mainAxisExtend = 300});

  final int itemCount;
  final double? mainAxisExtend;
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: itemCount,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: KSizes.gridViewSpacing,
        crossAxisSpacing: KSizes.gridViewSpacing,
        mainAxisExtent: 300,
      ),
      itemBuilder: itemBuilder,
    );
  }
}
