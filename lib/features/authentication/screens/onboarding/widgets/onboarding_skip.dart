import 'package:flutter/material.dart';
import 'package:gear_share_project/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:gear_share_project/utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: KDeviceUtilities.getAppBarHeight(),
      right: KSizes.defaultSpace,
      child: TextButton(
          onPressed: () => OnBoardingController.instance.skipPage(),
          child: const Text("Pomiń")),
    );
  }
}
