import 'package:gear_share_project/features/shop/models/category_model.dart';
import 'package:get/get.dart';

import '../../../common/widgets/services/firebase_storage_service.dart';
import '../../../data/dummy_data.dart';
import '../../../data/repositories/categories/category_repository.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;
  final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;
  final _firebaseStorageService = KFirebaseStorageService.instance;

  @override
  void onInit() {
    fetchCategories(); // Ładowanie kategorii na starcie
    super.onInit();
    uploadCategoriesToFirebase();
  }

  Future<void> uploadCategoriesToFirebase() async {
    await _firebaseStorageService
        .uploadCategoryImages(); // Prześlij obrazy i zapisz kategorie
  }

  /// Funkcja do ładowania kategorii z Firestore
  Future<void> fetchCategories() async {
    isLoading.value = true;

    try {
      final categories = await _categoryRepository.getAllCategories();
      allCategories.assignAll(categories);

      // Filtrujemy kategorie, aby wyświetlić tylko te z "isFeatured" jako true
      featuredCategories.assignAll(allCategories
          .where((category) => category.isFeatured && category.parentId.isEmpty)
          .take(8)
          .toList());
    } catch (e) {
      print('Błąd podczas ładowania kategorii: $e');
    } finally {
      isLoading.value = false; // Ustawiamy, że ładowanie zakończone
    }
  }

  /// Metoda do wysyłania danych, jeśli jeszcze nie zostały zapisane
  Future<void> uploadDummyCategoriesIfNeeded() async {
    final categories = await _categoryRepository.getAllCategories();
    if (categories.isEmpty) {
      // Jeśli kategorie nie zostały załadowane, wywołaj uploadDummyData
      await _categoryRepository.uploadDummyData(KDummyData.categories);
    }
  }

  /// --Ladowanie wybranej kategorii

  /// --Otrzymanie produktów z kategorii
}
