import 'package:flutter/material.dart';
import 'package:gear_share_project/common/widgets/appbar/appbar.dart';
import 'package:gear_share_project/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:gear_share_project/features/shop/controllers/rented_products_controller.dart';
import 'package:gear_share_project/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../models/product_model.dart';

class RentedProductsScreen extends StatelessWidget {
  const RentedProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RentedProductsController());

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: KAppBar(
          title: Text(
            'Wypożyczenia',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          showBackArror: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Wypożyczone przeze mnie'),
              Tab(text: 'Wypożyczone innym'),
            ],
          ),
        ),
        body: Obx(
          () {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            return TabBarView(
              children: [
                // Wypożyczone przeze mnie
                _buildProductGrid(
                  context,
                  controller.rentedProducts,
                  'Nie masz wypożyczonych produktów',
                ),

                // Wypożyczone innym
                _buildProductGrid(
                  context,
                  controller.myRentedOutProducts,
                  'Nikt nie wypożyczył twoich produktów',
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildProductGrid(
      BuildContext context, List<ProductModel> products, String emptyMessage) {
    if (products.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Iconsax.box, size: 64),
            const SizedBox(height: KSizes.spaceBtwItems),
            Text(
              emptyMessage,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(KSizes.defaultSpace),
      child: GridView.builder(
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: KSizes.gridViewSpacing,
          crossAxisSpacing: KSizes.gridViewSpacing,
          mainAxisExtent: 288,
        ),
        itemBuilder: (_, index) => KProductCardVertical(
          product: products[index],
        ),
      ),
    );
  }
}
