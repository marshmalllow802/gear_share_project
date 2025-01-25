import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gear_share_project/common/styles/shadow_styles.dart';
import 'package:gear_share_project/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:gear_share_project/common/widgets/icons/circular_icon.dart';
import 'package:gear_share_project/common/widgets/images/rounded_image.dart';
import 'package:gear_share_project/common/widgets/products/product_cards/product_location/product_location.dart';
import 'package:gear_share_project/common/widgets/products/product_price/product_price.dart';
import 'package:gear_share_project/common/widgets/texts/product_title_text.dart';
import 'package:gear_share_project/features/shop/screens/product/product_detail.dart';
import 'package:gear_share_project/utils/constants/colors.dart';
import 'package:gear_share_project/utils/constants/image_strings.dart';
import 'package:gear_share_project/utils/constants/sizes.dart';
import 'package:gear_share_project/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../availability/product_availability.dart';

class KProductCardVertical extends StatelessWidget {
  const KProductCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = KHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () => Get.to(() => const ProductDetail()),
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [KShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(KSizes.productImageRadius),
          color: dark ? KColors.darkGrey : KColors.white,
        ),
        child: Column(
          children: [
            /// Zdjęcie i ulubiony
            KRoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(KSizes.sm),
              backgroundColor: dark ? KColors.dark : KColors.light,
              child: const Stack(
                children: [
                  ///Zdjęcie
                  KRoundedImage(imageUrl: KImages.productImage5),

                  ///Ulubione
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: KCircularIcon(
                        icon: Iconsax.heart5,
                        color: KColors.buttonPrimary,
                      )),
                ],
              ),
            ),

            const SizedBox(height: KSizes.spaceBtwItems / 2),

            /// Opis
            const Padding(
              padding: EdgeInsets.only(left: KSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///Nazwa produktu
                  KProductTitleText(
                    title: 'Wiertarka, Magnum GX6',
                    smallSize: true,
                  ),
                  SizedBox(height: KSizes.spaceBtwItems / 2),

                  ///status dostępności
                  KProductAvailability(isAvailable: false),

                  SizedBox(height: KSizes.spaceBtwItems / 2),

                  ///lokalizacja
                  KProductLocation(location: 'Wrocław'),

                  ///cena za dzień
                  SizedBox(height: KSizes.spaceBtwItems / 2),
                ],
              ),
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.only(left: KSizes.sm),
              child: KProductPrice(price: '45', unit: 'za dzień'),
            ),
          ],
        ),
      ),
    );
  }
}
