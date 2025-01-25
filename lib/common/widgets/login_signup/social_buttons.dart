import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';

class KSocialButtons extends StatelessWidget {
  const KSocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: KColors.grey),
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
              width: KSizes.iconMd,
              height: KSizes.iconMd,
              image: AssetImage(KImages.google),
            ),
          ),
        ),
        const SizedBox(width: KSizes.spaceBtwItems),
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: KColors.grey),
              borderRadius: BorderRadius.circular(100)),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
              width: KSizes.iconMd,
              height: KSizes.iconMd,
              image: AssetImage(KImages.facebook),
            ),
          ),
        ),
      ],
    );
  }
}
