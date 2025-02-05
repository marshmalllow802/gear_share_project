import 'package:flutter/material.dart';
import 'package:gear_share_project/common/widgets/appbar/appbar.dart';
import 'package:gear_share_project/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:gear_share_project/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:gear_share_project/features/shop/controllers/category_controller.dart';
import 'package:gear_share_project/features/shop/controllers/search_controller.dart';
import 'package:gear_share_project/utils/constants/colors.dart';
import 'package:gear_share_project/utils/constants/sizes.dart';
import 'package:get/get.dart';

class SearchResultsScreen extends StatelessWidget {
  const SearchResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ProductSearchController.instance;
    final categoryController = Get.find<CategoryController>();

    return Scaffold(
      appBar: const KAppBar(
        showBackArror: true,
        title: Text('Wyniki wyszukiwania'),
      ),
      body: Column(
        children: [
          // Pole wyszukiwania
          const KSearchContainer(
            text: 'Szukaj',
            showBackground: false,
            autofocus: false,
          ),

          // Filtry
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(KSizes.defaultSpace),
            child: Obx(() => Row(
                  children: [
                    // Filtr kategorii
                    PopupMenuButton<String>(
                      child: Chip(
                        label: Text(
                          controller.selectedCategory.value.isEmpty
                              ? 'Kategorie'
                              : categoryController.categories
                                  .firstWhere((cat) =>
                                      cat.id ==
                                      controller.selectedCategory.value)
                                  .name,
                        ),
                        deleteIcon: const Icon(Icons.arrow_drop_down),
                        onDeleted: () {},
                        backgroundColor:
                            controller.selectedCategory.value.isEmpty
                                ? KColors.light
                                : KColors.primary.withOpacity(0.2),
                      ),
                      itemBuilder: (context) => [
                        // Opcja "Wszystkie kategorie"
                        const PopupMenuItem(
                          value: '',
                          child: Text('Wszystkie kategorie'),
                        ),
                        // Pozostałe kategorie
                        ...categoryController.categories
                            .map((category) => PopupMenuItem(
                                  value: category.id,
                                  child: Text(category.name),
                                ))
                            .toList(),
                      ],
                      onSelected: (categoryId) {
                        controller.filterByCategory(categoryId);
                      },
                    ),
                    const SizedBox(width: KSizes.spaceBtwItems),

                    // Filtr ceny
                    PopupMenuButton<String>(
                      child: Chip(
                        label: Text(
                          controller.sortOrder.value.isEmpty
                              ? 'Cena'
                              : controller.sortOrder.value == 'low_to_high'
                                  ? 'Od najniższej'
                                  : 'Od najwyższej',
                        ),
                        deleteIcon: const Icon(Icons.arrow_drop_down),
                        onDeleted: () {},
                        backgroundColor: controller.sortOrder.value.isEmpty
                            ? KColors.light
                            : KColors.primary.withOpacity(0.2),
                      ),
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: '',
                          child: Text('Domyślne sortowanie'),
                        ),
                        const PopupMenuItem(
                          value: 'low_to_high',
                          child: Text('Od najniższej'),
                        ),
                        const PopupMenuItem(
                          value: 'high_to_low',
                          child: Text('Od najwyższej'),
                        ),
                      ],
                      onSelected: (sortOrder) {
                        controller.sortByPrice(sortOrder);
                      },
                    ),

                    // Przycisk resetowania filtrów
                    if (controller.selectedCategory.value.isNotEmpty ||
                        controller.sortOrder.value.isNotEmpty) ...[
                      const SizedBox(width: KSizes.spaceBtwItems),
                      IconButton(
                        onPressed: () => controller.resetFilters(),
                        icon: const Icon(Icons.clear),
                        tooltip: 'Resetuj filtry',
                      ),
                    ],
                  ],
                )),
          ),

          // Lista wyników
          Expanded(
            child: Obx(
              () => controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : controller.searchResults.isEmpty
                      ? const Center(child: Text('Brak wyników'))
                      : GridView.builder(
                          padding: const EdgeInsets.all(KSizes.defaultSpace),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: KSizes.gridViewSpacing,
                            crossAxisSpacing: KSizes.gridViewSpacing,
                            mainAxisExtent: 288,
                          ),
                          itemCount: controller.searchResults.length,
                          itemBuilder: (_, index) => KProductCardVertical(
                            product: controller.searchResults[index],
                          ),
                        ),
            ),
          ),
        ],
      ),
    );
  }
}
