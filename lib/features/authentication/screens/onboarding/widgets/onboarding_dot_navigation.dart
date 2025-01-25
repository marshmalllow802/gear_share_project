import 'package:flutter/material.dart';
import 'package:gear_share_project/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:gear_share_project/utils/helpers/helper_functions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    final dark = KHelperFunctions.isDarkMode(context);

    return Positioned(
      bottom: KDeviceUtilities.getBottomNavigationBarHeight() + 25,
      left: KSizes.defaultSpace,
      child: SmoothPageIndicator(
        controller: controller.pageController,
        count: 3,
        onDotClicked: controller.dotNavigationClick,
        effect: ExpandingDotsEffect(
            activeDotColor: dark ? KColors.light : KColors.dark, dotHeight: 6),
      ),
    );
  }
}
