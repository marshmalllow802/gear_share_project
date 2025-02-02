import 'package:flutter/material.dart';
import 'package:gear_share_project/common/widgets/availability/product_availability.dart';
import 'package:gear_share_project/common/widgets/chips/choice_chip.dart';
import 'package:gear_share_project/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:gear_share_project/common/widgets/products/product_price/product_price.dart';
import 'package:gear_share_project/common/widgets/texts/product_title_text.dart';
import 'package:gear_share_project/common/widgets/texts/section_heading.dart';
import 'package:gear_share_project/features/shop/models/product_model.dart';
import 'package:gear_share_project/utils/constants/colors.dart';
import 'package:gear_share_project/utils/constants/enums.dart';
import 'package:gear_share_project/utils/constants/sizes.dart';
import 'package:gear_share_project/utils/helpers/helper_functions.dart';

class KProductAttributes extends StatelessWidget {
  final ProductModel product;

  const KProductAttributes({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final dark = KHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        /// -- wybrany atrybut opis i cena
        KRoundedContainer(
          padding: const EdgeInsets.all(KSizes.md),
          backgroundColor: dark ? KColors.darkerGrey : KColors.softGrey,
          child: Column(
            children: [
              Row(
                children: [
                  const KSectionHeading(title: 'Warianty'),
                  const SizedBox(width: KSizes.spaceBtwItems),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const KProductTitleText(
                              title: 'Cena : ', smallSize: true),
                          const SizedBox(width: KSizes.spaceBtwItems),
                          KProductPrice(
                              price: product.price.toString(),
                              unit: product.rentalPeriodDisplay),
                        ],
                      ),
                      Row(
                        children: [
                          const KProductTitleText(
                              title: 'Status : ', smallSize: true),
                          const SizedBox(width: KSizes.spaceBtwItems),
                          KProductAvailability(
                            status: product.status,
                            availabilityTextSize: TextSizes.medium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: KSizes.spaceBtwItems),

        /// -- Atrybuty
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const KSectionHeading(title: 'Okres wypożyczenia'),
            const SizedBox(height: KSizes.spaceBtwItems / 2),
            Wrap(
              spacing: 8,
              children: [
                KChoiceChip(
                  text: 'Na dzień',
                  selected: product.rentalPeriodEnum == RentalPeriod.oneDay,
                  onSelected: (value) {},
                ),
                KChoiceChip(
                  text: 'Na tydzień',
                  selected: product.rentalPeriodEnum == RentalPeriod.oneWeek,
                  onSelected: (value) {},
                ),
                KChoiceChip(
                  text: 'Na miesiąc',
                  selected: product.rentalPeriodEnum == RentalPeriod.oneMonth,
                  onSelected: (value) {},
                ),
                KChoiceChip(
                  text: 'Inny okres',
                  selected: product.rentalPeriodEnum == RentalPeriod.custom,
                  onSelected: (value) {},
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
