import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:gear_share_project/features/shop/models/category_model.dart';
import 'package:get/get.dart';

import '../../../common/widgets/services/firebase_storage_service.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  ///Variables
  final _db = FirebaseFirestore.instance;

  /// Otrzymaj wszystkie kategorie
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection('Categories').get();
      final list = snapshot.docs
          .map((document) => CategoryModel.fromSnapshot(document))
          .toList();
      return list;
    } on FirebaseException catch (e) {
      debugPrint("FirebaseFirestore error: $e");
      throw 'Coś poszło nie tak. Spróbuj ponownie później.';
    }
  }

  /// Załaduj kategorie do Cloud Firebase
/*Future<void> uploadDummyData(List<CategoryModel> categories) async {
    final storage = Get.put(KFirebaseStorageService());

    for (var category in categories) {
      final file = await storage.getImageDataFromAssets(category.image);
      final url = await storage.uploadImageData('Categories', file, category.name);

      category.image = url;
      await _db.collection("Categories").doc(category.id).set(category.toJson());
    }
}*/
// Dodajmy logowanie URL-a w metodzie uploadDummyData
  Future<void> uploadDummyData(List<CategoryModel> categories) async {
    final storage = Get.put(KFirebaseStorageService());

    try {
      for (var category in categories) {
        final file = await storage.getImageDataFromAssets(category.image);
        final url =
            await storage.uploadImageData('Categories', file, category.name);

        // Logowanie URL-a, aby upewnić się, że jest poprawny
        print("URL dla kategorii ${category.name}: $url");

        category.image = url;

        await _db
            .collection("Categories")
            .doc(category.id)
            .set(category.toJson());
      }

      print("Kategorie zostały wysłane do Firestore.");
    } catch (e) {
      print("Błąd podczas wysyłania kategorii: $e");
      rethrow; // Ponowne rzucenie wyjątku
    }
  }
}
