import 'package:flutter/material.dart';
import 'package:gear_share_project/features/shop/models/product_model.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../utils/constants/sizes.dart';
import '../../models/category_model.dart';
import '../../services/firebase_service.dart';

class KCategoryScreen extends StatefulWidget {
  final CategoryModel category;

  const KCategoryScreen({super.key, required this.category});

  @override
  State<KCategoryScreen> createState() => _KCategoryScreenState();
}

class _KCategoryScreenState extends State<KCategoryScreen> {
  String searchQuery = '';
  List<ProductModel> allProducts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  Future<void> loadProducts() async {
    final products = await Get.find<FirebaseService>()
        .getProductsByCategory(widget.category.id);
    setState(() {
      allProducts = products;
      isLoading = false;
    });
  }

  List<ProductModel> get filteredProducts {
    if (searchQuery.isEmpty) return allProducts;
    return allProducts
        .where((product) =>
            product.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
            product.description
                .toLowerCase()
                .contains(searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppBar(
        showBackArror: true,
        title: Text(
          widget.category.name,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(KSizes.defaultSpace),
          child: Column(
            children: [
              KSearchContainer(
                showBackground: false,
                text: 'Szukaj',
                onChanged: (value) => setState(() => searchQuery = value),
              ),
              const SizedBox(height: KSizes.spaceBtwSections),
              if (isLoading)
                const Center(child: CircularProgressIndicator())
              else if (filteredProducts.isEmpty)
                const Center(child: Text('Brak produktów'))
              else
                KGridLayout(
                  itemCount: filteredProducts.length,
                  itemBuilder: (_, index) => KProductCardVertical(
                    product: filteredProducts[index],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
