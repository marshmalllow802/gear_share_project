import 'package:flutter/material.dart';
import 'package:gear_share_project/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:gear_share_project/utils/constants/colors.dart';
import 'package:gear_share_project/utils/constants/sizes.dart';
import 'package:gear_share_project/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/device/device_utility.dart';

class OboardingCircularButton extends StatelessWidget {
  const OboardingCircularButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = KHelperFunctions.isDarkMode(context);
    return Positioned(
      right: KSizes.defaultSpace,
      bottom: KDeviceUtilities.getBottomNavigationBarHeight(),
      child: ElevatedButton(
        onPressed: () => OnBoardingController.instance.nextPage(),
        style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            backgroundColor: dark ? KColors.primary : Colors.black),
        child: const Icon(Iconsax.arrow_right_3),
      ),
    );
  }
}
