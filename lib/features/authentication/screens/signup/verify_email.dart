import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gear_share_project/common/widgets/success_screen/success_screen.dart';
import 'package:gear_share_project/features/authentication/screens/login/login.dart';
import 'package:gear_share_project/utils/constants/image_strings.dart';
import 'package:gear_share_project/utils/constants/sizes.dart';
import 'package:gear_share_project/utils/constants/text_strings.dart';
import 'package:gear_share_project/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Get.offAll(() => const LoginScreen()),
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(KSizes.defaultSpace),
          child: Column(
            children: [
              ///Image
              Image(
                image: const AssetImage(KImages.deliveredEmailIllustration),
                width: KHelperFunctions.screenWidth() * 0.6,
              ),

              const SizedBox(
                height: KSizes.spaceBtwSections,
              ),

              ///Title and subtitle
              Text(KTexts.confirmEmail,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center),
              const SizedBox(
                height: KSizes.spaceBtwItems,
              ),
              Text('support@gearshare.com',
                  style: Theme.of(context).textTheme.labelLarge,
                  textAlign: TextAlign.center),
              const SizedBox(
                height: KSizes.spaceBtwItems,
              ),
              Text(KTexts.confirmEmailSubTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center),

              const SizedBox(
                height: KSizes.spaceBtwSections,
              ),

              ///buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () => Get.to(
                          () => SuccessScreen(
                            image: KImages.staticSuccessIllustration,
                            title: KTexts.yourAccountCreatedTitle,
                            subTitle: KTexts.yourAccountCreatedSubTitle,
                            onPressed: () => Get.to(() => const LoginScreen()),
                          ),
                        ),
                    child: const Text(KTexts.kContinue)),
              ),
              const SizedBox(
                height: KSizes.spaceBtwItems,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                    onPressed: () {}, child: const Text(KTexts.resendEmail)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
