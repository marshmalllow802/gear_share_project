import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:gear_share_project/features/shop/models/category_model.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  /// Załadowanie kategorii z Firestore
  Future<void> fetchCategories() async {
    isLoading.value = true;
    try {
      final categoriesRef = await _db.collection('Categories').get();
      debugPrint('Fetched categories from Firebase:');
      categoriesRef.docs.forEach((doc) {
        debugPrint('Category data: ${doc.data()}');
      });

      categories.value = categoriesRef.docs
          .map((doc) => CategoryModel.fromJson(doc.data()))
          .toList();

      allCategories.assignAll(categories);
      featuredCategories.assignAll(
          categories.where((category) => category.isFeatured).toList());
    } catch (e) {
      debugPrint('Error fetching categories: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Prześlij kategorie początkowe jeśli kolekcja jest pusta
  Future<void> uploadDummyCategoriesIfNeeded() async {
    try {
      final categoriesRef = _db.collection('Categories');
      final snapshot = await categoriesRef.get();

      if (snapshot.docs.isEmpty) {
        debugPrint('No categories found, uploading dummy data...');
        final batch = _db.batch();

        final dummyCategories = [
          CategoryModel(
            id: 'books',
            name: 'Books',
            image: 'assets/images/categories/books.png',
            isFeatured: true,
          ),
          CategoryModel(
              id: 'vehicles',
              name: 'Vehicles',
              image: 'assets/images/categories/vehicles.png'),
          CategoryModel(
              id: 'clothing',
              name: 'Clothing',
              image: 'assets/images/categories/clothing.png'),
          CategoryModel(
              id: 'tools',
              name: 'Tools',
              image: 'assets/images/categories/tools.png'),
          CategoryModel(
              id: 'others',
              name: 'Others',
              image: 'assets/images/categories/others.png'),
        ];

        for (var category in dummyCategories) {
          final docRef = categoriesRef.doc(category.id);
          debugPrint('Uploading category: ${category.toJson()}');
          batch.set(docRef, category.toJson());
        }

        await batch.commit();
        await fetchCategories();
        debugPrint('Categories uploaded successfully');
      }
    } catch (e) {
      debugPrint('Error uploading categories: $e');
    }
  }

  /// Migracja starego formatu kategorii do nowego
  Future<void> migrateCategories() async {
    try {
      debugPrint('Starting categories migration...');
      final categoriesRef = _db.collection('Categories');
      final snapshot = await categoriesRef.get();

      for (var doc in snapshot.docs) {
        final data = doc.data();
        final updatedData = {
          'id': doc.id,
          'name': data['Name'] ?? data['name'] ?? '',
          'image': data['Image'] ?? data['image'] ?? '',
          'isActive': true,
          'isFeatured': data['IsFeatured'] ?? data['isFeatured'] ?? false,
        };

        debugPrint('Migrating category ${doc.id}: $updatedData');
        await categoriesRef.doc(doc.id).set(updatedData);
      }

      debugPrint('Categories migration completed');
      await fetchCategories(); // Перезагружаем категории
    } catch (e) {
      debugPrint('Error migrating categories: $e');
    }
  }
}
