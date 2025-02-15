import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:gear_share_project/data/repositories/authentication/authentication_repository.dart';
import 'package:gear_share_project/features/personalization/models/user_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Zapisywanie danych usera w firestore

  Future<void> saveUserRecord(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
    } on FirebaseException catch (e) {
      debugPrint("FirebaseFirestore error: $e");
      throw 'Coś poszło nie tak. Spróbuj ponownie później.';
    }
  }

  /// Funkcja do pobrania danych o użytkowniku po jego id
  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    } on FirebaseException catch (e) {
      debugPrint("FirebaseFirestore error: $e");
      throw 'Coś poszło nie tak. Spróbuj ponownie później.';
    }
  }

  /// Funkcja do aktualizacji danych uzytkownika w Firestore
  Future<void> updateUserDetails(UserModel updateUser) async {
    try {
      await _db.collection("Users").doc(updateUser.id).set(updateUser.toJson());
    } on FirebaseException catch (e) {
      debugPrint("FirebaseFirestore error: $e");
      throw 'Coś poszło nie tak. Spróbuj ponownie później.';
    }
  }

  /// Aktualizowanie każdego pola w konkretnej kolekcji użytkownika
  /*Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .update(json);
    } on FirebaseException catch (e) {
      debugPrint("FirebaseFirestore error: $e");
      throw 'Coś poszło nie tak. Spróbuj ponownie później.';
    }
  }*/
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      final uid = AuthenticationRepository.instance.authUser?.uid;
      if (uid != null) {
        print("Aktualizowanie Firestore dla użytkownika: $uid");
        await _db.collection("Users").doc(uid).update(json);
        print("Zaktualizowano dokument w Firestore");
      }
    } on FirebaseException catch (e) {
      print("Błąd podczas aktualizacji Firestore: $e");
      throw 'Coś poszło nie tak z aktualizowaniem Firestore. Spróbuj ponownie.';
    }
  }

  /// Usunięcie danych użytkownika z Firestore
  Future<void> removeUserRecord(String userId) async {
    try {
      await _db.collection("Users").doc(userId).delete();
    } on FirebaseException catch (e) {
      debugPrint("FirebaseFirestore error: $e");
      throw 'Coś poszło nie tak. Spróbuj ponownie później.';
    }
  }

  ///Dodanie zdjęcia profilowego
/*Future<String> uploadImage (String path, XFile image) async {
  try {
    final ref = FirebaseStorage.instance.ref(path).child(image.name);
    await ref.putFile(File(image.path));
    final url = await ref.getDownloadURL();
    return url;
  } on FirebaseException catch (e) {
    debugPrint("FirebaseFirestore error: $e");
    throw 'Coś poszło nie tak. Spróbuj ponownie później.';
  }
}*/
  Future<String> uploadImage(String path, XFile image) async {
    try {
      // Logujemy wybraną ścieżkę do zdjęcia
      print("Przesyłanie zdjęcia do Firebase Storage: ${image.path}");

      // Tworzymy referencję do miejsca w Firebase Storage
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      final file = File(image.path);

      // Sprawdzamy, czy plik istnieje w systemie
      if (await file.exists()) {
        print("Plik istnieje, przesyłanie...");
      } else {
        print("Plik nie istnieje! Ścieżka: ${image.path}");
        return ''; // Jeśli plik nie istnieje, zwróć pusty string
      }

      // Przesyłanie zdjęcia do Firebase Storage
      final uploadTask = ref.putFile(file);
      uploadTask.snapshotEvents.listen((event) {
        print(
            "Przesyłanie: ${event.bytesTransferred} / ${event.totalBytes} bytes");
      });

      // Czekamy, aż operacja zakończy się sukcesem
      await uploadTask.whenComplete(() async {
        print("Zdjęcie zostało przesłane do Firebase Storage.");
      });

      // Uzyskiwanie URL po zakończeniu przesyłania
      final url = await ref.getDownloadURL();
      print("URL zdjęcia z Firebase Storage: $url");

      return url; // Zwracamy URL zdjęcia
    } on FirebaseException catch (e) {
      print("Błąd podczas przesyłania zdjęcia: $e");
      throw 'Coś poszło nie tak z przesyłaniem zdjęcia. Spróbuj ponownie.';
    }
  }
}
