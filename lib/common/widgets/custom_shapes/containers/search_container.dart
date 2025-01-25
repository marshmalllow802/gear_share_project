import 'package:flutter/material.dart';
import 'package:gear_share_project/utils/constants/colors.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/helpers/helper_functions.dart';

class KSearchContainer extends StatelessWidget {
  const KSearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal_1,
    this.showBackground = true,
    this.showBoarder = true,
    this.onTap,
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBoarder;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = KHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: KSizes.defaultSpace),
        child: Container(
          width: KDeviceUtilities.getScreenWidth(context),
          padding: const EdgeInsets.all(KSizes.md),
          decoration: BoxDecoration(
              color: showBackground
                  ? dark
                      ? KColors.dark
                      : KColors.light
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(KSizes.cardRadiusLg),
              border: showBoarder ? Border.all(color: KColors.softGrey) : null),
          child: Row(
            children: [
              Icon(icon, color: KColors.softGrey),
              const SizedBox(
                width: KSizes.spaceBtwItems,
              ),
              Text(text, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
