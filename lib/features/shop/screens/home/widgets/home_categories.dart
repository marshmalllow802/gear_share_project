import 'package:flutter/material.dart';
import 'package:gear_share_project/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:gear_share_project/features/shop/controllers/category_controller.dart';
import 'package:gear_share_project/features/shop/screens/category_pages/category_screen.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/effects/category_shimmer.dart';

class KHomeCategories extends StatelessWidget {
  const KHomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());

    return Obx(() {
      if (categoryController.isLoading.value) return const KCategoryShimmer();
      if (categoryController.featuredCategories.isEmpty) {
        return Center(
            child: Text('Nie znaleziono informacji',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .apply(color: Colors.white)));
      }

      return SizedBox(
        height: 80,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: categoryController.featuredCategories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            final category = categoryController.featuredCategories[index];
            return KVerticaalImageText(
                image: category.image,
                title: category.name,
                onTap: () => Get.to(() => KCategoryScreen(
                    category: category)) // Przekazujemy category
                );
          },
        ),
      );
    });
  }
}
