import 'package:flutter/material.dart';
import 'package:gear_share_project/common/widgets/availability/product_availability.dart';
import 'package:gear_share_project/common/widgets/products/product_cards/product_location/product_location.dart';
import 'package:gear_share_project/common/widgets/products/product_price/product_price.dart';
import 'package:gear_share_project/common/widgets/texts/product_title_text.dart';
import 'package:gear_share_project/features/shop/models/product_model.dart';
import 'package:gear_share_project/utils/constants/enums.dart';
import 'package:gear_share_project/utils/constants/sizes.dart';
import 'package:gear_share_project/utils/helpers/helper_functions.dart';

class KProductMetaData extends StatelessWidget {
  final ProductModel product;

  const KProductMetaData({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final darkMode = KHelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///Cena
        KProductPrice(
            price: product.price.toString(),
            unit: product.rentalPeriodDisplay,
            isLarge: true),
        SizedBox(height: KSizes.spaceBtwItems / 1.5),

        ///Dostępność
        Row(
          children: [
            KProductTitleText(title: 'Status:  '),
            SizedBox(height: KSizes.spaceBtwItems),
            KProductAvailability(
              status: "Dostępny",
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
