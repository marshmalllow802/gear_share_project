import 'package:flutter/material.dart';
import 'package:gear_share_project/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:gear_share_project/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:gear_share_project/common/widgets/texts/section_heading.dart';
import 'package:gear_share_project/utils/constants/sizes.dart';
import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import 'widgets/home_appbar.dart';
import 'widgets/home_categories.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const KPrimaryHeaderContainer(
              child: Column(
                children: [
                  KHomeAppBar(),
                  SizedBox(
                    height: KSizes.spaceBtwSections,
                  ),

                  /// Wyszukiwarka
                  KSearchContainer(
                    text: 'Szukaj',
                  ),
                  SizedBox(
                    height: KSizes.spaceBtwSections,
                  ),

                  /// Kategorie
                  Padding(
                    padding: EdgeInsets.only(left: KSizes.defaultSpace),
                    child: Column(
                      children: [
                        /// Nagłówek
                        KSectionHeading(
                          title: 'Popularne kategorie',
                          textColor: Colors.white,
                        ),
                        SizedBox(
                          height: KSizes.spaceBtwItems,
                        ),

                        ///Kategorie
                        KHomeCategories(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: KSizes.spaceBtwSections,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(KSizes.defaultSpace),
              child: Column(
                children: [
                  const KSectionHeading(
                    title: 'Najnowsze produkty',
                  ),
                  const SizedBox(
                    height: KSizes.spaceBtwItems,
                  ),
                  KGridLayout(
                      itemCount: 4,
                      itemBuilder: (_, index) => const KProductCardVertical()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
