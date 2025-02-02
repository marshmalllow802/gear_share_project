import 'package:flutter/material.dart';
import 'package:gear_share_project/utils/constants/colors.dart';
import 'package:gear_share_project/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/enums.dart';

class KProductAvailability extends StatelessWidget {
  const KProductAvailability({
    super.key,
    required this.status,
    this.color,
    this.maxLines = 1,
    this.textAlign = TextAlign.center,
    this.availabilityTextSize = TextSizes.small,
  });

  final String status;
  final Color? color;
  final int maxLines;
  final TextAlign? textAlign;
  final TextSizes availabilityTextSize;

  bool get isAvailable => status == 'Dostępny';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isAvailable ? Iconsax.tick_circle : Iconsax.clock,
          size: KSizes.iconSm,
          color: isAvailable ? KColors.success : KColors.warning,
        ),
        const SizedBox(width: KSizes.xs),
        Text(
          isAvailable ? 'Dostępny' : 'Wypożyczony',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: availabilityTextSize == TextSizes.small
              ? Theme.of(context).textTheme.labelMedium!.apply(color: color)
              : availabilityTextSize == TextSizes.medium
                  ? Theme.of(context).textTheme.bodyLarge!.apply(color: color)
                  : availabilityTextSize == TextSizes.large
                      ? Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .apply(color: color)
                      : Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: color),
        )
      ],
    );
  }
}
