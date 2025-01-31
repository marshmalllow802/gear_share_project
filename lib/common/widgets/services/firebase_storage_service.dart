import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../data/dummy_data.dart';

/*class KFirebaseStorageService extends GetxController {
  static KFirebaseStorageService get instance => Get.find();

  final _firebaseStorage = FirebaseStorage.instance;

  Future<Uint8List> getImageDataFromAssets(String path) async {
    final byteData = await rootBundle.load(path);
    final imageData = byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
    return imageData;
  }

 */ /* Future<String> uploadImageData(String path, Uint8List image, String name) async {
    final ref = _firebaseStorage.ref(path).child(name);
    await ref.putData(image);
    final url = await ref.getDownloadURL();
    return url;
  }*/ /*
  Future<String> uploadImageData(String path, Uint8List image, String name) async {
    final ref = _firebaseStorage.ref(path).child(name);

    try {
      await ref.putData(image); // Wysyłanie danych obrazu
      final url = await ref.getDownloadURL(); // Pobieranie URL obrazu po wysłaniu
      return url;
    } catch (e) {
      print("Błąd podczas przesyłania obrazu: $e");
      rethrow; // Ponowne rzucenie wyjątku
    }
  }


  Future<String>uploadImageFile(String path, XFile image) async {
    final ref = _firebaseStorage.ref(path).child(image.name);
    await ref.putFile(File(image.path));
    final url = await ref.getDownloadURL();
    return url;
  }
}*/

class KFirebaseStorageService extends GetxController {
  static KFirebaseStorageService get instance => Get.find();
  final _firebaseStorage = FirebaseStorage.instance;

  // Funkcja do wczytania obrazu z assets
  Future<Uint8List> getImageDataFromAssets(String path) async {
    final byteData = await rootBundle.load(path);
    final imageData = byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
    return imageData;
  }

  // Funkcja do przesyłania obrazu do Firebase Storage
  Future<String> uploadImageData(
      String path, Uint8List image, String name) async {
    final ref = _firebaseStorage.ref(path).child(name);

    try {
      await ref.putData(image); // Wysyłanie danych obrazu
      final url =
          await ref.getDownloadURL(); // Pobieranie URL obrazu po wysłaniu
      print("Image uploaded successfully! URL: $url"); // Debugowanie
      return url;
    } catch (e) {
      print("Błąd podczas przesyłania obrazu: $e");
      rethrow; // Ponowne rzucenie wyjątku
    }
  }

  // Funkcja do załadowania obrazków z assets do Firebase Storage i zapisanie URL w Firestore
  Future<void> uploadCategoryImages() async {
    try {
      for (var category in KDummyData.categories) {
        // Wczytaj obrazek z assets
        final imageData = await getImageDataFromAssets(category.image);

        // Załaduj obrazek do Firebase Storage i uzyskaj URL
        final imageUrl =
            await uploadImageData('categories/', imageData, category.name);

        // Zaktualizuj kategorię z URL obrazu
        category.image = imageUrl;

        // Teraz możesz zapisać kategorię w Firestore
        await FirebaseFirestore.instance
            .collection('Categories')
            .doc(category.id)
            .set(category.toJson());
      }
    } catch (e) {
      print("Błąd podczas ładowania obrazków: $e");
    }
  }
}
