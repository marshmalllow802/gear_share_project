import 'package:flutter/material.dart';
import 'package:gear_share_project/common/widgets/appbar/appbar.dart';
import 'package:gear_share_project/common/widgets/icons/circular_icon.dart';
import 'package:gear_share_project/common/widgets/layouts/grid_layout.dart';
import 'package:gear_share_project/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:gear_share_project/features/shop/controllers/favorites_controller.dart';
import 'package:gear_share_project/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FavoritesController>();
    final dark = KHelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: KAppBar(
        title: Text(
          'Polubione',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArror: true,
      ),
      body: GetBuilder<FavoritesController>(
        builder: (controller) {
          print('Odświeżam widok ulubionych'); // Debug
          print(
              'Liczba ulubionych: ${controller.favoriteProducts.length}'); // Debug

          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.favoriteProducts.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  KCircularIcon(
                    icon: Iconsax.heart,
                    backgroundColor: dark ? KColors.dark : KColors.white,
                    color: KColors.primary,
                  ),
                  const SizedBox(height: 16),
                  const Text('Brak polubionych produktów'),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  KGridLayout(
                    itemCount: controller.favoriteProducts.length,
                    itemBuilder: (_, index) {
                      final product = controller.favoriteProducts[index];
                      print('Wyświetlam produkt: ${product.title}'); // Debug
                      return KProductCardVertical(
                        product: product,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
