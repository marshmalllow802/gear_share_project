import 'package:flutter/material.dart';
import 'package:gear_share_project/utils/constants/colors.dart';
import 'package:gear_share_project/utils/constants/enums.dart';
import 'package:gear_share_project/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class KProductLocation extends StatelessWidget {
  const KProductLocation({
    super.key,
    required this.location,
    this.color,
    this.maxLines = 1,
    this.textAlign = TextAlign.center,
    this.locationTextSize = TextSizes.small,
  });

  final String location;
  final Color? color;
  final int maxLines;
  final TextAlign? textAlign;
  final TextSizes locationTextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Iconsax.location,
          size: KSizes.iconSm,
          color: KColors.grey,
        ),
        const SizedBox(width: KSizes.xs),
        Text(
          location,
          textAlign: textAlign,
          overflow: TextOverflow.ellipsis,
          maxLines: maxLines,
          style: locationTextSize == TextSizes.small
              ? Theme.of(context).textTheme.labelMedium!.apply(color: color)
              : locationTextSize == TextSizes.medium
                  ? Theme.of(context).textTheme.bodyLarge!.apply(color: color)
                  : locationTextSize == TextSizes.large
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
