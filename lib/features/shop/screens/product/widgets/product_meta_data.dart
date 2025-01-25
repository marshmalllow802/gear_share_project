import 'package:flutter/material.dart';
import 'package:gear_share_project/common/widgets/availability/product_availability.dart';
import 'package:gear_share_project/common/widgets/products/product_cards/product_location/product_location.dart';
import 'package:gear_share_project/common/widgets/products/product_price/product_price.dart';
import 'package:gear_share_project/common/widgets/texts/product_title_text.dart';
import 'package:gear_share_project/utils/constants/enums.dart';
import 'package:gear_share_project/utils/constants/sizes.dart';
import 'package:gear_share_project/utils/helpers/helper_functions.dart';

class KProductMetaData extends StatelessWidget {
  const KProductMetaData({super.key});

  @override
  Widget build(BuildContext context) {
    final darkMode = KHelperFunctions.isDarkMode(context);
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///Cena
        KProductPrice(price: '45', unit: 'na tydzień', isLarge: true),
        SizedBox(height: KSizes.spaceBtwItems / 1.5),

        ///Dostępność
        Row(
          children: [
            KProductTitleText(title: 'Status:  '),
            SizedBox(height: KSizes.spaceBtwItems),
            KProductAvailability(
              isAvailable: true,
              availabilityTextSize: TextSizes.medium,
            ),
          ],
        ),

        SizedBox(height: KSizes.spaceBtwItems / 1.5),

        ///Lokalizacja
        Row(
          children: [
            KProductTitleText(title: 'Lokalizacja:  '),
            SizedBox(height: KSizes.spaceBtwItems),
            KProductLocation(
              location: 'Gdańsk',
              locationTextSize: TextSizes.medium,
            ),
          ],
        )
      ],
    );
  }
}
