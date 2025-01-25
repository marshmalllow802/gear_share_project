import 'package:flutter/material.dart';
import 'package:gear_share_project/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:gear_share_project/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:gear_share_project/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:gear_share_project/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:gear_share_project/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:gear_share_project/utils/constants/image_strings.dart';
import 'package:gear_share_project/utils/constants/text_strings.dart';
import 'package:get/get.dart';

class onBoardingScreen extends StatelessWidget {
  const onBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    return Scaffold(
      body: Stack(
        children: [
          //Horizontal scrollable pages
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                image: KImages.onBoardingImage1,
                title: KTexts.onBoardingTitle1,
                subTitle: KTexts.onBoardingSubTitle1,
              ),
              OnBoardingPage(
                image: KImages.onBoardingImage2,
                title: KTexts.onBoardingTitle2,
                subTitle: KTexts.onBoardingSubTitle2,
              ),
              OnBoardingPage(
                image: KImages.onBoardingImage3,
                title: KTexts.onBoardingTitle3,
                subTitle: KTexts.onBoardingSubTitle3,
              ),
            ],
          ),
          //Skip button
          const OnBoardingSkip(),

          //Dot Navigation SmoothPage indicator
          const OnBoardingDotNavigation(),

          //Circular Button
          const OboardingCircularButton(),
        ],
      ),
    );
  }
}
