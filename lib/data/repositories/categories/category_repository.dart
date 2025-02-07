import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:gear_share_project/features/shop/models/category_model.dart';
import 'package:get/get.dart';

import '../../../common/widgets/services/firebase_storage_service.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  ///Variables
  final _db = FirebaseFirestore.instance;

  /// Otrzymanie wszytskich kategorii Firestore
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection('Categories').get();
      final list = snapshot.docs
          .map((doc) => CategoryModel.fromJson(doc.data()))
          .toList();
      return list;
    } catch (e) {
      debugPrint('Error getting categories: $e');
      throw 'Something went wrong. Please try again later.';
    }
  }

  /// Przesyłanie kategorii do Firestore
  Future<void> uploadDummyData(List<CategoryModel> categories) async {
    final storage = Get.put(KFirebaseStorageService());

    try {
      for (var category in categories) {
        final file = await storage.getImageDataFromAssets(category.image);
        final url =
            await storage.uploadImageData('Categories', file, category.name);
        debugPrint('URL for category ${category.name}: $url');

        final updatedCategory = CategoryModel(
          id: category.id,
          name: category.name,
          image: url,
          isActive: category.isActive,
          isFeatured: category.isFeatured,
        );

        await _db
            .collection('Categories')
            .doc(category.id)
            .set(updatedCategory.toJson());
      }
      debugPrint('Categories uploaded successfully');
    } catch (e) {
      debugPrint('Error uploading categories: $e');
      rethrow;
    }
  }
}
