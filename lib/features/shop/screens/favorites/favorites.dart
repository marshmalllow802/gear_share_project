import 'package:flutter/material.dart';
import 'package:gear_share_project/common/widgets/appbar/appbar.dart';
import 'package:gear_share_project/common/widgets/icons/circular_icon.dart';
import 'package:gear_share_project/common/widgets/layouts/grid_layout.dart';
import 'package:gear_share_project/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:gear_share_project/features/shop/screens/home/home.dart';
import 'package:gear_share_project/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppBar(
        title: Text(
          'Polubione',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArror: true,
        actions: [
          KCircularIcon(
              icon: Iconsax.add, onPressed: () => Get.to(const HomeScreen())),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(KSizes.defaultSpace),
          child: Column(
            children: [
              KGridLayout(
                  itemCount: 4,
                  itemBuilder: (_, index) {
                    debugPrint(index.toString());
                    return const KProductCardVertical();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
