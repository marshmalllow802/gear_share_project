import 'package:flutter/material.dart';
import 'package:gear_share_project/utils/constants/colors.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/shop/controllers/search_controller.dart';
import '../../../../features/shop/screens/search/search_results.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/helpers/helper_functions.dart';

class KSearchContainer extends StatelessWidget {
  const KSearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal_1,
    this.showBackground = true,
    this.showBorder = true,
    this.onTap,
    this.autofocus = false,
    this.initialText = '',
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback? onTap;
  final bool autofocus;
  final String initialText;

  @override
  Widget build(BuildContext context) {
    final dark = KHelperFunctions.isDarkMode(context);
    final controller = Get.put(ProductSearchController());

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KSizes.defaultSpace),
      child: Container(
        width: KDeviceUtilities.getScreenWidth(context),
        padding: const EdgeInsets.all(KSizes.xs),
        decoration: BoxDecoration(
          color: showBackground
              ? dark
                  ? KColors.dark
                  : KColors.light
              : Colors.transparent,
          borderRadius: BorderRadius.circular(KSizes.cardRadiusLg),
          border: showBorder ? Border.all(color: KColors.grey) : null,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                autofocus: autofocus,
                controller: TextEditingController(text: initialText),
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    controller.searchProducts(value);
                    if (!Get.currentRoute.contains('search_results')) {
                      Get.to(() => const SearchResultsScreen());
                    }
                  }
                },
                decoration: InputDecoration(
                  hintText: text,
                  hintStyle: Theme.of(context).textTheme.bodySmall,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  filled: false,
                  prefixIcon: Icon(icon, color: KColors.grey),
                  contentPadding: const EdgeInsets.symmetric(vertical: 13),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
