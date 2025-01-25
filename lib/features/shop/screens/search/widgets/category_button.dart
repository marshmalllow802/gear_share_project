import 'package:flutter/material.dart';
import 'package:gear_share_project/utils/constants/colors.dart';
import 'package:gear_share_project/utils/constants/sizes.dart';
import 'package:iconsax/iconsax.dart';

class KCategoryButton extends StatelessWidget {
  const KCategoryButton(
      {super.key, required this.title, required this.onPressed});
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: KSizes.md),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: KColors.softGrey),
            bottom: BorderSide(color: KColors.softGrey),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: KSizes.md),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Iconsax.camera5,
                      size: KSizes.iconLg, color: KColors.primary),
                  const SizedBox(width: KSizes.lg),
                  Text(title, style: Theme.of(context).textTheme.headlineSmall),
                ],
              ),
              const Icon(Iconsax.arrow_right_3,
                  size: KSizes.iconLg, color: KColors.primary),
            ],
          ),
        ),
      ),
    );
  }
}
