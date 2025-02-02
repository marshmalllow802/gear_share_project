import 'package:flutter/material.dart';
import 'package:gear_share_project/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import '../../../../../common/widgets/icons/circular_icon.dart';
import '../../../../../common/widgets/images/rounded_image.dart';
import '../../../../../features/shop/controllers/favorites_controller.dart';
import '../../../../../features/shop/models/product_model.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class KProductImageSlider extends StatefulWidget {
  final ProductModel product;

  const KProductImageSlider({super.key, required this.product});

  @override
  State<KProductImageSlider> createState() => _KProductImageSliderState();
}

class _KProductImageSliderState extends State<KProductImageSlider> {
  int currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final dark = KHelperFunctions.isDarkMode(context);
    final controller = Get.put(FavoritesController());

    return KCurvedEdgeWidget(
      child: Container(
        color: dark ? KColors.darkerGrey : KColors.lightGrey,
        child: Stack(
          children: [
            ///Główne zdjęcie
            SizedBox(
              height: 400,
              child: Image.network(widget.product.images[currentImageIndex]),
            ),

            ///Slider
            Positioned(
              right: 0,
              bottom: 30,
              left: KSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: KSizes.spaceBtwItems),
                  itemCount: widget.product.images.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (_, index) => GestureDetector(
                    onTap: () => setState(() => currentImageIndex = index),
                    child: KRoundedImage(
                      width: 80,
                      backgroundColor: dark ? KColors.dark : KColors.white,
                      border: Border.all(
                        color: currentImageIndex == index
                            ? KColors.primary
                            : KColors.grey,
                        width: currentImageIndex == index ? 2 : 1,
                      ),
                      padding: const EdgeInsets.all(KSizes.sm),
                      imageUrl: widget.product.images[index],
                      isNetworkImage: true,
                    ),
                  ),
                ),
              ),
            ),

            ///AppBar ikonki
            KAppBar(
              showBackArror: true,
              showBackArrowWithBackground: true,
              backgroundColor: Colors.transparent,
              actions: [
                FutureBuilder<bool>(
                  future: controller.isProductFavorite(widget.product.id),
                  builder: (context, snapshot) {
                    final isFavorite = snapshot.data ?? false;
                    return KCircularIcon(
                      icon: isFavorite ? Iconsax.heart5 : Iconsax.heart,
                      color: isFavorite ? KColors.primary : null,
                      backgroundColor: dark ? KColors.dark : KColors.white,
                      onPressed: () =>
                          controller.toggleFavorite(widget.product.id),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
