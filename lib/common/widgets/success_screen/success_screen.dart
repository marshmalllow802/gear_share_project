import 'package:flutter/material.dart';
import 'package:gear_share_project/common/styles/spacing_styles.dart';
import 'package:gear_share_project/utils/constants/sizes.dart';
import 'package:gear_share_project/utils/constants/text_strings.dart';
import 'package:gear_share_project/utils/helpers/helper_functions.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen(
      {super.key,
      required this.image,
      required this.title,
      required this.subTitle,
      required this.onPressed});

  final String image, title, subTitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: KSpacingStyle.paddingWithAppBarHeight * 2,
          child: Column(
            children: [
              Image(
                image: AssetImage(image),
                errorBuilder: (context, error, stackTrace) {
                  return const Text('nie udało się załadować obrazka');
                },
                width: KHelperFunctions.screenWidth() * 0.6,
              ),

              const SizedBox(
                height: KSizes.spaceBtwSections,
              ),

              ///Title and subtitle
              Text(title,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center),
              const SizedBox(
                height: KSizes.spaceBtwItems,
              ),
              Text(subTitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center),

              const SizedBox(
                height: KSizes.spaceBtwSections,
              ),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: onPressed, child: const Text(KTexts.kContinue)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
