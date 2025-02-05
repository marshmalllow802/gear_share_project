import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../common/widgets/loaders/loaders.dart';
import '../../../data/repositories/user/user_repository.dart';
import '../models/product_model.dart';

class FavoritesController extends GetxController {
  static FavoritesController get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final _userRepository = Get.find<UserRepository>();

  final favoriteProducts = <ProductModel>[].obs;
  final favoriteStatus = <String, bool>{}.obs;
  final isLoading = false.obs;
  final favoriteProductIds = <String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    getFavoriteProducts();
  }

  bool isFavorite(String productId) {
    return favoriteStatus[productId] ?? false;
  }

  void toggleFavorite(String productId) async {
    try {
      final userId = _auth.currentUser?.uid;
      if (userId == null) return;

      if (favoriteProductIds.contains(productId)) {
        // Usuń z ulubionych
        favoriteProductIds.remove(productId);
        favoriteProducts.removeWhere((product) => product.id == productId);
        favoriteStatus[productId] = false;

        // Aktualizuj w Firebase w kolekcji Users
        await _db.collection("Users").doc(userId).update({
          'favorites': FieldValue.arrayRemove([productId])
        });

        KLoaders.successSnackBar(
          title: 'Usunięto z ulubionych',
          message: 'Produkt został usunięty z ulubionych',
        );
      } else {
        // Dodaj do ulubionych
        favoriteProductIds.add(productId);
        favoriteStatus[productId] = true;

        // Aktualizuj w Firebase w kolekcji Users
        await _db.collection("Users").doc(userId).update({
          'favorites': FieldValue.arrayUnion([productId])
        });

        // Pobierz dane produktu i dodaj do listy
        final productDoc =
            await _db.collection('Products').doc(productId).get();
        if (productDoc.exists) {
          final data = productDoc.data() as Map<String, dynamic>;
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
            id: productId,
            title: data['title']?.toString() ?? '',
            description: data['description']?.toString() ?? '',
            price: (data['price'] is num)
                ? (data['price'] as num).toDouble()
                : 0.0,
            images: List<String>.from(data['images'] ?? []),
            status: data['status']?.toString() ?? '',
            author: data['author']?.toString() ?? '',
            category: data['category']?.toString() ?? '',
            rentalPeriod: data['rentalPeriod']?.toString() ?? '',
            createdAt: createdAt ?? DateTime.now(),
          );

          favoriteProducts.add(product);
        }

        KLoaders.successSnackBar(
          title: 'Dodano do ulubionych',
          message: 'Produkt został dodany do ulubionych',
        );
      }
    } catch (e) {
      print('Błąd podczas przełączania ulubionych: $e');
    }
  }

  Future<void> getFavoriteProducts() async {
    try {
      isLoading.value = true;
      final userId = _auth.currentUser?.uid;
      print('Pobieranie ulubionych dla użytkownika: $userId');

      if (userId == null) {
        print('Brak zalogowanego użytkownika');
        favoriteProducts.clear();
        favoriteStatus.clear();
        favoriteProductIds.clear();
        return;
      }

      // Pobierz ulubione z dokumentu użytkownika z kolekcji Users
      final userDoc = await _db.collection("Users").doc(userId).get();
      final favorites = List<String>.from(userDoc.data()?['favorites'] ?? []);

      print('Znalezione ID produktów: $favorites');

      // Aktualizacja stanu
      favoriteStatus.clear();
      favoriteProducts.clear();
      favoriteProductIds.clear();

      // Pobierz szczegóły produktów
      for (var productId in favorites) {
        favoriteStatus[productId] = true;
        favoriteProductIds.add(productId);

        final productDoc =
            await _db.collection('Products').doc(productId).get();
        if (productDoc.exists) {
          try {
            final data = productDoc.data() as Map<String, dynamic>;
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
              id: productId,
              title: data['title']?.toString() ?? '',
              description: data['description']?.toString() ?? '',
              price: (data['price'] is num)
                  ? (data['price'] as num).toDouble()
                  : 0.0,
              images: List<String>.from(data['images'] ?? []),
              status: data['status']?.toString() ?? '',
              author: data['author']?.toString() ?? '',
              category: data['category']?.toString() ?? '',
              rentalPeriod: data['rentalPeriod']?.toString() ?? '',
              createdAt: createdAt ?? DateTime.now(),
            );

            favoriteProducts.add(product);
            print('Pobrano produkt ${product.title}');
          } catch (e) {
            print('Błąd podczas przetwarzania produktu $productId: $e');
          }
        }
      }

      print(
          'Zaktualizowano listę ulubionych. Liczba produktów: ${favoriteProducts.length}');
    } catch (e) {
      print('Błąd podczas pobierania ulubionych: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> isProductFavorite(String productId) async {
    return favoriteProductIds.contains(productId);
  }
}
