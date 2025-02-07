import 'package:flutter/material.dart';
import 'package:gear_share_project/common/widgets/icons/circular_icon.dart';
import 'package:gear_share_project/features/shop/controllers/rented_products_controller.dart';
import 'package:gear_share_project/features/shop/controllers/wallet_controller.dart';
import 'package:gear_share_project/features/shop/models/product_model.dart';
import 'package:gear_share_project/utils/constants/colors.dart';
import 'package:gear_share_project/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/loaders/loaders.dart';

class KBottomProposeOffer extends StatelessWidget {
  final ProductModel product;

  const KBottomProposeOffer({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final walletController = Get.put(WalletController());
    final rentedProductsController = Get.put(RentedProductsController());
    final dark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(KSizes.md),
      decoration: BoxDecoration(
        color: dark ? KColors.dark : KColors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(KSizes.cardRadiusLg),
          topRight: Radius.circular(KSizes.cardRadiusLg),
        ),
        boxShadow: [
          BoxShadow(
            color: KColors.darkGrey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Przycisk czatu
          KCircularIcon(
            icon: Iconsax.messages,
            backgroundColor: KColors.black,
            width: 56,
            height: 56,
            color: KColors.white,
            onPressed: () {},
          ),
          SizedBox(
            width: KSizes.spaceBtwItems / 2,
          ),

          // Przycisk Wypożycz
          Expanded(
            child: ElevatedButton(
              onPressed: product.status != 'Dostępny'
                  ? null
                  : () {
                      Get.dialog(
                        AlertDialog(
                          title: const Text('Potwierdź wypożyczenie'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  'Cena: ${product.price} zł ${product.rentalPeriodDisplay}'),
                              const SizedBox(height: KSizes.spaceBtwItems),
                              const Text(
                                  'Po potwierdzeniu otrzymasz SMS z adresem odbioru.'),
                              const SizedBox(height: KSizes.spaceBtwItems),
                              Obx(() => Text(
                                    'Dostępne środki: ${walletController.balance.value} zł',
                                    style: TextStyle(
                                      color: walletController.balance.value >=
                                              product.price
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                  )),
                            ],
                          ),
                          actions: [
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () => Get.back(),
                                  child: const Text('Anuluj'),
                                ),
                                SizedBox(width: KSizes.spaceBtwItems / 2),
                                ElevatedButton(
                                  onPressed: () async {
                                    final success =
                                        await walletController.processRental(
                                      product.author,
                                      product.price,
                                      product.id,
                                    );

                                    if (success) {
                                      Get.back();
                                      await rentedProductsController
                                          .getRentedProducts();
                                      KLoaders.successSnackBar(
                                        title: 'Sukces',
                                        message:
                                            'Produkt został wypożyczony. Szczegóły otrzymasz SMS-em.',
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(KSizes.md),
                                    backgroundColor: KColors.primary,
                                  ),
                                  child: const Text('Potwierdź'),
                                ),
                              ],
                            ),

                          ],
                        ),
                      );
                    },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(KSizes.md),
                backgroundColor: KColors.primary,
              ),
              child: const Text('Wypożycz'),
            ),
          ),
        ],
      ),
    );
  }
}
