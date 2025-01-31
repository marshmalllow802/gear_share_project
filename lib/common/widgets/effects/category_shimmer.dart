import 'package:flutter/material.dart';
import 'package:gear_share_project/common/widgets/effects/shimmer.dart';

import '../../../utils/constants/sizes.dart';

class KCategoryShimmer extends StatelessWidget {
  const KCategoryShimmer({
    super.key,
    this.itemCount = 6,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: itemCount,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, __) =>
            const SizedBox(width: KSizes.spaceBtwItems),
        itemBuilder: (_, __) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              KShimmerEffect(width: 55, height: 55, radius: 55),
              SizedBox(height: KSizes.spaceBtwItems / 2),
              KShimmerEffect(width: 55, height: 8),
            ],
          );
        },
      ),
    );
  }
}
