import 'package:get/get.dart';

import '../models/product_model.dart';
import '../services/firebase_service.dart';

class ProductSearchController extends GetxController {
  static ProductSearchController get instance => Get.find();

  final RxList<ProductModel> searchResults = <ProductModel>[].obs;
  final RxBool isLoading = false.obs;
  final firebaseService = FirebaseService();

  final RxString selectedCategory = ''.obs;
  final RxString sortOrder = ''.obs;
  final RxString currentSearchQuery = ''.obs; // dodaj to
  final RxList<ProductModel> allSearchResults =
      <ProductModel>[].obs; // dodaj to

  Future<void> searchProducts(String query) async {
    try {
      isLoading.value = true;
      currentSearchQuery.value = query; // zapisz query

      final products = await firebaseService.getAllProducts();

      var filtered = products.where((product) {
        return product.title.toLowerCase().contains(query.toLowerCase()) ||
            product.description.toLowerCase().contains(query.toLowerCase());
      }).toList();

      searchResults.assignAll(filtered);
      allSearchResults.assignAll(filtered); // zachowaj kopię wszystkich wyników
    } catch (e) {
      print('Error searching products: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void filterByCategory(String categoryId) {
    selectedCategory.value = categoryId;
    if (allSearchResults.isNotEmpty) {
      if (categoryId.isEmpty) {
        // Przywróć wszystkie wyniki wyszukiwania
        searchResults.assignAll(allSearchResults);
      } else {
        final filtered = allSearchResults
            .where((product) => product.category == categoryId)
            .toList();
        searchResults.assignAll(filtered);
      }
    }
  }

  void sortByPrice(String order) {
    sortOrder.value = order;
    if (order.isEmpty) {
      // Przywróć oryginalną kolejność wyników wyszukiwania
      searchResults.assignAll(allSearchResults);
    } else {
      var sorted = List<ProductModel>.from(searchResults);
      if (order == 'low_to_high') {
        sorted.sort((a, b) => a.price.compareTo(b.price));
      } else {
        sorted.sort((a, b) => b.price.compareTo(a.price));
      }
      searchResults.assignAll(sorted);
    }
  }

  void resetFilters() {
    selectedCategory.value = '';
    sortOrder.value = '';
    // Przywróć wszystkie wyniki wyszukiwania
    searchResults.assignAll(allSearchResults);
  }
}
