import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gear_share_project/utils/constants/image_strings.dart';
import 'package:gear_share_project/utils/constants/sizes.dart';
import 'package:gear_share_project/utils/constants/text_strings.dart';
import 'package:gear_share_project/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(KSizes.defaultSpace),
          child: Column(
            children: [
              Image(
                image: const AssetImage(KImages.deliveredEmailIllustration),
                width: KHelperFunctions.screenWidth() * 0.6,
              ),

              const SizedBox(
                height: KSizes.spaceBtwSections,
              ),

              ///Title and subtitle
              Text(KTexts.changeYourPasswordTitle,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center),
              const SizedBox(
                height: KSizes.spaceBtwItems,
              ),
              Text(KTexts.changeYourPasswordSubTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center),

              const SizedBox(
                height: KSizes.spaceBtwSections,
              ),

              ///Butonns
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {}, child: const Text(KTexts.done)),
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
