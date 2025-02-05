import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gear_share_project/common/widgets/loaders/loaders.dart';
import 'package:gear_share_project/features/shop/models/product_model.dart';
import 'package:gear_share_project/features/shop/screens/my_products/edit_product.dart';
import 'package:get/get.dart';

class MyProductsController extends GetxController {
  static MyProductsController get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final myProducts = <ProductModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getMyProducts();
  }

  Future<void> getMyProducts() async {
    try {
      isLoading.value = true;
      final userId = _auth.currentUser?.uid;

      if (userId == null) {
        myProducts.clear();
        return;
      }

      final productsSnapshot = await _db
          .collection('Products')
          .where('author', isEqualTo: userId)
          .get();

      myProducts.clear();

      for (var doc in productsSnapshot.docs) {
        final data = doc.data();
        DateTime? createdAt;
        try {
          if (data['createdAt'] is Timestamp) {
            createdAt = (data['createdAt'] as Timestamp).toDate();
          } else if (data['createdAt'] is String) {
            createdAt = DateTime.parse(data['createdAt'] as String);
          }
        } catch (e) {
          createdAt = DateTime.now();
        }

        final product = ProductModel(
          id: doc.id,
          title: data['title']?.toString() ?? '',
          description: data['description']?.toString() ?? '',
          price:
              (data['price'] is num) ? (data['price'] as num).toDouble() : 0.0,
          images: List<String>.from(data['images'] ?? []),
          status: data['status']?.toString() ?? '',
          author: data['author']?.toString() ?? '',
          category: data['category']?.toString() ?? '',
          rentalPeriod: data['rentalPeriod']?.toString() ?? '',
          createdAt: createdAt ?? DateTime.now(),
        );

        myProducts.add(product);
      }
    } catch (e) {
      print('Błąd podczas pobierania produktów: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteProduct(String productId) async {
    try {
      await _db.collection('Products').doc(productId).delete();
      myProducts.removeWhere((product) => product.id == productId);
      KLoaders.successSnackBar(
        title: 'Sukces',
        message: 'Ogłoszenie zostało usunięte',
      );
    } catch (e) {
      KLoaders.errorSnackBar(
        title: 'Błąd',
        message: 'Nie udało się usunąć ogłoszenia',
      );
    }
  }

  void navigateToEditProduct(ProductModel product) {
    Get.to(() => EditProductScreen(product: product));
  }

  Future<void> updateProduct(
      String productId, Map<String, dynamic> data) async {
    try {
      isLoading.value = true;

      // Aktualizuj produkt w Firebase
      await _db.collection('Products').doc(productId).update(data);

      // Aktualizuj lokalną listę
      final index = myProducts.indexWhere((product) => product.id == productId);
      if (index != -1) {
        final updatedProduct = myProducts[index].copyWith(
          title: data['title'],
          description: data['description'],
          price: data['price'],
          category: data['category'],
          rentalPeriod: data['rentalPeriod'],
          status: data['status'],
        );
        myProducts[index] = updatedProduct;
      }

      KLoaders.successSnackBar(
        title: 'Sukces',
        message: 'Ogłoszenie zostało zaktualizowane',
      );

      Get.back(); // Wróć do listy produktów
    } catch (e) {
      KLoaders.errorSnackBar(
        title: 'Błąd',
        message: 'Nie udało się zaktualizować ogłoszenia',
      );
    } finally {
      isLoading.value = false;
    }
  }
}
