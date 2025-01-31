import 'package:flutter/material.dart';
import 'package:gear_share_project/common/widgets/appbar/appbar.dart';
import 'package:gear_share_project/common/widgets/layouts/list_layout.dart';
import 'package:gear_share_project/common/widgets/notifications/notifications_icon.dart';
import 'package:gear_share_project/features/shop/controllers/category_controller.dart';
import 'package:gear_share_project/features/shop/screens/search/widgets/category_button.dart';
import 'package:gear_share_project/utils/constants/sizes.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/effects/category_shimmer.dart';
import '../category_pages/category_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());

    return Obx(() {
      // Warunek ładowania danych
      if (categoryController.isLoading.value) {
        return const KCategoryShimmer();
      }

      // Brak danych
      if (categoryController.featuredCategories.isEmpty) {
        return Center(
          child: Text(
            'Nie znaleziono informacji',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .apply(color: Colors.white),
          ),
        );
      }

      return Scaffold(
        appBar: KAppBar(
          title: Text(
            'Szukaj',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            KNotificationCounterIcon(
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            /// Wyszukiwarka
            const KSearchContainer(
              showBackground: false,
              text: 'Szukaj',
            ),
            const SizedBox(
              height: KSizes.spaceBtwSections,
            ),

            /// Kategorie
            KListLayout(
              itemCount: categoryController.featuredCategories.length,
              itemBuilder: (_, index) {
                final category = categoryController.featuredCategories[index];
                return KCategoryButton(
                  title: category.name,
                  onPressed: () =>
                      Get.to(() => KCategoryScreen(category: category)),
                );
              },
            ),
          ],
        ),
      );
    });
  }
}
