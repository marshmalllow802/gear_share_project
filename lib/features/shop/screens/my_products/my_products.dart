import 'package:flutter/material.dart';
import 'package:gear_share_project/common/widgets/appbar/appbar.dart';
import 'package:gear_share_project/common/widgets/layouts/grid_layout.dart';
import 'package:gear_share_project/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:gear_share_project/features/shop/controllers/my_products_controller.dart';
import 'package:gear_share_project/utils/constants/colors.dart';
import 'package:gear_share_project/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../models/product_model.dart';

class MyProductsScreen extends StatelessWidget {
  const MyProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyProductsController());
    final dark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: KAppBar(
        title: Text(
          'Twoje ogłoszenia',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArror: true,
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.myProducts.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Iconsax.bag_tick,
                      size: 64, color: dark ? KColors.white : KColors.black),
                  const SizedBox(height: KSizes.spaceBtwItems),
                  Text(
                    'Nie masz jeszcze żadnych ogłoszeń',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(KSizes.defaultSpace),
              child: Column(
                children: [
                  KGridLayout(
                    itemCount: controller.myProducts.length,
                    itemBuilder: (_, index) {
                      final product = controller.myProducts[index];
                      return Stack(
                        children: [
                          KProductCardVertical(product: product),
                          // Przycisk menu z opcjami
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Container(
                              decoration: BoxDecoration(
                                color: dark ? KColors.dark : KColors.white,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.more_vert),
                                onPressed: () =>
                                    _showProductOptions(context, product),
                                color: KColors.primary,
                              ),
                            ),
                          ),
                        ],
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

  void _showProductOptions(BuildContext context, ProductModel product) {
    final controller = MyProductsController.instance;
    final dark = Theme.of(context).brightness == Brightness.dark;

    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        color: dark ? KColors.dark : KColors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edytuj ogłoszenie'),
              onTap: () {
                Navigator.pop(context);
                controller.navigateToEditProduct(product);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Usuń ogłoszenie',
                  style: TextStyle(color: Colors.red)),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Potwierdź usunięcie'),
                    content:
                        const Text('Czy na pewno chcesz usunąć to ogłoszenie?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Anuluj'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // zamknij dialog
                          Navigator.pop(context); // zamknij bottom sheet
                          controller.deleteProduct(product.id);
                        },
                        child: const Text('Usuń',
                            style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
