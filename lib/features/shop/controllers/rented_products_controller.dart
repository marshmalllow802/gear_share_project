import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gear_share_project/features/shop/models/product_model.dart';
import 'package:get/get.dart';

class RentedProductsController extends GetxController {
  static RentedProductsController get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  final rentedProducts = <ProductModel>[].obs;
  final myRentedOutProducts =
      <ProductModel>[].obs; // Produkty wypożyczone innym
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getRentedProducts();
  }

  Future<void> getRentedProducts() async {
    try {
      isLoading.value = true;
      final userId = _auth.currentUser?.uid;
      if (userId == null) return;

      print('Pobieranie wypożyczonych produktów dla użytkownika: $userId');

      // Pobierz produkty wypożyczone przez użytkownika
      final rentedByMeDocs = await _db
          .collection('RentedProducts')
          .where('renterId', isEqualTo: userId)
          .get();

      print(
          'Znaleziono ${rentedByMeDocs.docs.length} produktów wypożyczonych przez użytkownika');

      // Pobierz produkty wypożyczone od użytkownika
      final rentedFromMeDocs = await _db
          .collection('RentedProducts')
          .where('ownerId', isEqualTo: userId)
          .get();

      print(
          'Znaleziono ${rentedFromMeDocs.docs.length} produktów wypożyczonych od użytkownika');

      rentedProducts.clear();
      myRentedOutProducts.clear();

      // Przetwórz produkty wypożyczone przez użytkownika
      for (var doc in rentedByMeDocs.docs) {
        print('Przetwarzanie dokumentu wypożyczenia: ${doc.id}');
        print('Dane dokumentu: ${doc.data()}');

        final product =
            await _getProductDetails(doc.data()['productId'] as String);
        if (product != null) {
          print('Dodawanie produktu do listy: ${product.title}');
          rentedProducts.add(product);
        } else {
          print('Nie znaleziono produktu o ID: ${doc.data()['productId']}');
        }
      }

      // Przetwórz produkty wypożyczone od użytkownika
      for (var doc in rentedFromMeDocs.docs) {
        print('Przetwarzanie dokumentu wypożyczenia od użytkownika: ${doc.id}');
        final product =
            await _getProductDetails(doc.data()['productId'] as String);
        if (product != null) {
          print(
              'Dodawanie produktu do listy wypożyczonych innym: ${product.title}');
          myRentedOutProducts.add(product);
        }
      }

      print('Zakończono pobieranie. Znaleziono:');
      print('- Wypożyczone przeze mnie: ${rentedProducts.length}');
      print('- Wypożyczone innym: ${myRentedOutProducts.length}');
    } catch (e) {
      print('Błąd podczas pobierania wypożyczonych produktów: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<ProductModel?> _getProductDetails(String productId) async {
    try {
      final productDoc = await _db.collection('Products').doc(productId).get();

      if (productDoc.exists) {
        final data = productDoc.data()!;
        DateTime? createdAt;

        // Bezpieczna konwersja daty
        if (data['createdAt'] is Timestamp) {
          createdAt = (data['createdAt'] as Timestamp).toDate();
        } else if (data['createdAt'] is String) {
          createdAt = DateTime.tryParse(data['createdAt'] as String);
        }

        return ProductModel(
          id: productDoc.id,
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
      }
      return null;
    } catch (e) {
      print('Błąd podczas pobierania szczegółów produktu: $e');
      print(
          'Dane produktu: ${(await _db.collection('Products').doc(productId).get()).data()}');
      return null;
    }
  }
}
