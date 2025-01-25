import 'package:flutter/material.dart';
import 'package:gear_share_project/common/widgets/icons/circular_icon.dart';
import 'package:gear_share_project/utils/constants/colors.dart';
import 'package:gear_share_project/utils/constants/sizes.dart';
import 'package:gear_share_project/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';

class KBottomProposeOffer extends StatelessWidget {
  const KBottomProposeOffer({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = KHelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: KSizes.defaultSpace,
        vertical: KSizes.defaultSpace / 2,
      ),
      decoration: BoxDecoration(
        color: dark ? KColors.darkerGrey : KColors.light,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(KSizes.cardRadiusLg),
          topRight: Radius.circular(KSizes.cardRadiusLg),
        ),
      ),
      child: Row(
       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
           KCircularIcon(
              icon: Iconsax.messages,
              backgroundColor: KColors.black,
              width: 56,
              height: 56,
              color: KColors.white,
              onPressed: (){},
          ),



          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(KSizes.md),
              backgroundColor: KColors.black,
              side: const BorderSide(color: KColors.black),
            ),
            child: const Text('Proponuj ofertę'),
          ),
        ],
      ),
    );
  }
}
