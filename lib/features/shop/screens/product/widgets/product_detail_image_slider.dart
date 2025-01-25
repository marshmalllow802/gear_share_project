import 'package:flutter/material.dart';
import 'package:gear_share_project/utils/helpers/helper_functions.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import '../../../../../common/widgets/icons/circular_icon.dart';
import '../../../../../common/widgets/images/rounded_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';

class KProductImageSlider extends StatelessWidget {
  const KProductImageSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = KHelperFunctions.isDarkMode(context);
    return KCurvedEdgeWidget(
      child: Container(
        color: dark ? KColors.darkerGrey : KColors.lightGrey,
        child: Stack(
          children: [
            ///Główne zdjęcie
            const SizedBox(
              height: 400,
              child: Padding(
                padding: EdgeInsets.all(KSizes.productImageRadius * 2),
                child: Center(
                    child: Image(image: AssetImage(KImages.productImage5))),
              ),
            ),

            ///Slider
            Positioned(
              right: 0,
              bottom: 30,
              left: KSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: KSizes.spaceBtwItems),
                  itemCount: 10,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (_, index) => KRoundedImage(
                      width: 80,
                      backgroundColor: dark ? KColors.dark : KColors.white,
                      border: Border.all(color: KColors.primary),
                      padding: const EdgeInsets.all(KSizes.sm),
                      imageUrl: KImages.productImage5),
                ),
              ),
            ),

            ///AppBar ikonki
            const KAppBar(
              showBackArror: true,
              actions: [
                KCircularIcon(icon: Iconsax.heart5, color: KColors.primary)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
