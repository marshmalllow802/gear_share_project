import 'package:flutter/material.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../utils/constants/sizes.dart';
import '../../models/category_model.dart';

class KCategoryScreen extends StatelessWidget {
  final CategoryModel category; // Kategoria jako argument w konstruktorze

  const KCategoryScreen(
      {super.key,
      required this.category}); // Konstruktor, który przyjmuje kategorię

  @override
  Widget build(BuildContext context) {
    // Sprawdzamy, czy obrazek jest poprawnie przekazany
    print("Obrazek kategorii: ${category.image}");

    return Scaffold(
      appBar: KAppBar(
        showBackArror: true,
        title: Text(
          category.name, // Wyświetlamy nazwę kategorii
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(KSizes.defaultSpace),
          child: Column(
            children: [
              const KSearchContainer(
                showBackground: false,
                text: 'Szukaj',
              ),
              const SizedBox(
                height: KSizes.spaceBtwSections,
              ),
              KGridLayout(
                itemCount: 4,
                // Zmieniamy na odpowiednią liczbę produktów dla danej kategorii
                itemBuilder: (_, index) {
                  return const KProductCardVertical(); // Jeśli masz produkty w tej kategorii, tutaj je pokażesz
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
