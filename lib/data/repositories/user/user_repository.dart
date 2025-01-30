import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:gear_share_project/data/repositories/authentication/authentication_repository.dart';
import 'package:gear_share_project/features/personalization/models/user_model.dart';
import 'package:get/get.dart';

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
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection("Users")
          .doc(AuthenticationRepository.instance.authUser?.uid)
          .update(json);
    } on FirebaseException catch (e) {
      debugPrint("FirebaseFirestore error: $e");
      throw 'Coś poszło nie tak. Spróbuj ponownie później.';
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
}
