import 'package:flutter/material.dart';
import 'package:gear_share_project/common/styles/shadow_styles.dart';
import 'package:gear_share_project/common/widgets/availability/product_availability.dart';
import 'package:gear_share_project/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:gear_share_project/common/widgets/icons/circular_icon.dart';
import 'package:gear_share_project/common/widgets/images/rounded_image.dart';
import 'package:gear_share_project/common/widgets/products/product_price/product_price.dart';
import 'package:gear_share_project/common/widgets/texts/product_title_text.dart';
import 'package:gear_share_project/features/shop/models/product_model.dart';
import 'package:gear_share_project/utils/constants/colors.dart';
import 'package:gear_share_project/utils/constants/routes.dart';
import 'package:gear_share_project/utils/constants/sizes.dart';
import 'package:gear_share_project/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class KProductCardVertical extends StatelessWidget {
  final ProductModel product;

  const KProductCardVertical({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final dark = KHelperFunctions.isDarkMode(context);
    debugPrint('product.images[0]: ${product.images[0]}');
    return GestureDetector(
      onTap: () => Get.toNamed(
        KRoutes.product.replaceAll(':id', product.id),
      ),
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
            /// Thumbnail и избранное
            KRoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(KSizes.sm),
              backgroundColor: dark ? KColors.dark : KColors.light,
              child: Stack(
                children: [
                  ///Zdjęcie
                  KRoundedImage(
                    imageUrl: product.images[0],
                    isNetworkImage: product.author != "",
                  ),

                  ///Ulubione
                  const Positioned(
                    bottom: 0,
                    right: 0,
                    child: KCircularIcon(
                      icon: Iconsax.heart5,
                      color: KColors.buttonPrimary,
                    ),
                  ),
                ],
              ),
            ),

            /// Информация о продукте
            Expanded(
              // Оборачиваем в Expanded
              child: Padding(
                padding: const EdgeInsets.all(KSizes.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /*Text(
                      product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: KSizes.xs),*/
                    KProductTitleText(
                      title: product.title,
                      smallSize: true,
                    ),
                    const SizedBox(height: KSizes.xs),
                    Text(
                      product.categoryName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    SizedBox(height: KSizes.spaceBtwItems / 2),

                    ///status dostępności
                    KProductAvailability(status: product.status),
                    const SizedBox(height: KSizes.xs),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /*Expanded(
                          child: Text(
                            '${product.price.toString()} zł',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),*/
                        /*Container(
                          padding: const EdgeInsets.all(KSizes.xs),
                          decoration: BoxDecoration(
                            color: product.status == 'available'
                                ? Colors.green.withOpacity(0.1)
                                : Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(KSizes.xs),
                          ),
                          child: Text(
                            product.status,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  color: product.status == 'available'
                                      ? Colors.green
                                      : Colors.red,
                                ),
                          ),
                        ),*/
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(left: KSizes.sm),
                      child: KProductPrice(
                          price: product.price.toString(),
                          unit: product.rentalPeriodDisplay),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
