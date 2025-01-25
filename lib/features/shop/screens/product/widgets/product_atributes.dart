import 'package:flutter/material.dart';
import 'package:gear_share_project/common/widgets/availability/product_availability.dart';
import 'package:gear_share_project/common/widgets/chips/choice_chip.dart';
import 'package:gear_share_project/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:gear_share_project/common/widgets/products/product_price/product_price.dart';
import 'package:gear_share_project/common/widgets/texts/product_title_text.dart';
import 'package:gear_share_project/common/widgets/texts/section_heading.dart';
import 'package:gear_share_project/utils/constants/colors.dart';
import 'package:gear_share_project/utils/constants/enums.dart';
import 'package:gear_share_project/utils/constants/sizes.dart';
import 'package:gear_share_project/utils/helpers/helper_functions.dart';

class KProductAttributes extends StatelessWidget {
  const KProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = KHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        /// -- wybrany atrybut opis i cena
        KRoundedContainer(
          padding: const EdgeInsets.all(KSizes.md),
          backgroundColor: dark ? KColors.darkerGrey : KColors.softGrey,
          child: const Column(
            children: [
              Row(
                children: [
                  KSectionHeading(title: 'Warianty'),
                  SizedBox(
                    width: KSizes.spaceBtwItems,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          KProductTitleText(title: 'Cena : ', smallSize: true),
                          SizedBox(
                            width: KSizes.spaceBtwItems,
                          ),

                          ///Cena
                          KProductPrice(price: '45', unit: 'na tydzień'),
                        ],
                      ),
                      Row(
                        children: [
                          KProductTitleText(
                              title: 'Status : ', smallSize: true),
                          SizedBox(
                            width: KSizes.spaceBtwItems,
                          ),
                          KProductAvailability(
                            isAvailable: true,
                            availabilityTextSize: TextSizes.medium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              // KProductTitleText(
              //   title:
              //       'To jest opis produktu nie powinien przekroczyć maksymalnie 4 linii',
              //   smallSize: true,
              //   maxLines: 4,
              // ),
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
                    text: 'Na dzień', selected: false, onSelected: (value) {}),
                KChoiceChip(
                    text: 'Na tydzień', selected: true, onSelected: (value) {}),
                KChoiceChip(
                    text: 'Na 2 tyg.', selected: false, onSelected: (value) {}),
                KChoiceChip(
                    text: 'Na miesiąc',
                    selected: false,
                    onSelected: (value) {}),
              ],
            )
          ],
        ),
      ],
    );
  }
}
