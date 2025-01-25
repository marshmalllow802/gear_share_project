import 'package:flutter/material.dart';
import 'package:gear_share_project/utils/constants/sizes.dart';
import 'package:gear_share_project/utils/helpers/helper_functions.dart';

import '../../../utils/constants/colors.dart';

class KVerticaalImageText extends StatelessWidget {
  const KVerticaalImageText({
    super.key,
    required this.image,
    required this.title,
    this.textColor = KColors.white,
    this.backgroundColor,
    this.onTap,
  });

  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = KHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: KSizes.spaceBtwItems),
        child: Column(
          children: [
            /// Okragla ikona
            Container(
              width: 56,
              height: 56,
              padding: const EdgeInsets.all(KSizes.sm),
              decoration: BoxDecoration(
                color:
                    backgroundColor ?? (dark ? KColors.black : KColors.white),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Image(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                  color: dark ? KColors.light : KColors.dark,
                ),
              ),
            ),
            const SizedBox(
              height: KSizes.spaceBtwItems / 2,
            ),
            SizedBox(
              width: 55,
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .apply(color: textColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
