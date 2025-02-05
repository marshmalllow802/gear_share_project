import 'package:flutter/material.dart';
import 'package:gear_share_project/common/widgets/appbar/appbar.dart';
import 'package:gear_share_project/features/shop/controllers/wallet_controller.dart';
import 'package:gear_share_project/utils/constants/colors.dart';
import 'package:gear_share_project/utils/constants/sizes.dart';
import 'package:get/get.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Inicjalizacja kontrolera
    final controller = Get.put(WalletController());

    return Scaffold(
      appBar: KAppBar(
        title: Text(
          'Twój portfel',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArror: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(KSizes.defaultSpace),
        child: Column(
          children: [
            // Saldo
            Card(
              child: Padding(
                padding: const EdgeInsets.all(KSizes.defaultSpace),
                child: Column(
                  children: [
                    const Text('Dostępne środki'),
                    const SizedBox(height: KSizes.spaceBtwItems),
                    Obx(() => Text(
                          '${controller.balance.value} zł',
                          style: Theme.of(context).textTheme.headlineLarge,
                        )),
                  ],
                ),
              ),
            ),
            const SizedBox(height: KSizes.spaceBtwSections),

            // Przycisk doładowania
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.dialog(
                    AlertDialog(
                      title: const Text('Doładuj portfel'),
                      content: TextField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Kwota',
                          suffixText: 'zł',
                        ),
                        onSubmitted: (value) {
                          final amount = double.tryParse(value);
                          if (amount != null && amount > 0) {
                            controller.addFunds(amount);
                            Get.back();
                          }
                        },
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Get.back(),
                          child: const Text('Anuluj'),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(KSizes.md),
                  backgroundColor: KColors.primary,
                ),
                child: const Text('Doładuj portfel'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
