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
    this.showBorder = true,
    this.onTap,
    this.onChanged,
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final dark = KHelperFunctions.isDarkMode(context);

    return GestureDetector(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: KSizes.defaultSpace),
      child: Container(
        width: KDeviceUtilities.getScreenWidth(context),
        padding: const EdgeInsets.all(KSizes.xs),
        decoration: BoxDecoration(
          color: showBackground
                  ? dark
                      ? KColors.dark
                      : KColors.light
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(KSizes.cardRadiusLg),
          border: showBorder ? Border.all(color: KColors.grey) : null,
        ),
        child: TextField(
          onTap: onTap,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: text,
            hintStyle: Theme.of(context).textTheme.bodySmall,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            filled: false,
            contentPadding: const EdgeInsets.symmetric(vertical: 13),
            prefixIcon: Icon(icon, color: KColors.grey),
          ),
        ),
      ),
    ));
  }
}
