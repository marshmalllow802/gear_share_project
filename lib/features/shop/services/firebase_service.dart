import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gear_share_project/features/personalization/models/user_model.dart';
import 'package:gear_share_project/features/shop/models/product_model.dart';

class FirebaseService {
  static final FirebaseService _instance = FirebaseService._internal();

  factory FirebaseService() => _instance;

  FirebaseService._internal();

  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<ProductModel>> getAllProducts() async {
    const collectionPath = "Products";

    try {
      debugPrint('Getting all products from Firebase...');

      final collectionRef = _db.collection(collectionPath);
      final collectionSnapshot = await collectionRef.get();

      debugPrint('Collection exists: ${collectionSnapshot.docs.isNotEmpty}');
      debugPrint('Collection size: ${collectionSnapshot.size}');

      if (collectionSnapshot.docs.isEmpty) {
        debugPrint('No documents found in collection');
        return [];
      }

      // Получаем все документы без сортировки
      final snapshot = await collectionRef.get();
      debugPrint('Got ${snapshot.docs.length} products');

      // Выводим данные первого документа для проверки
      if (snapshot.docs.isNotEmpty) {
        final firstDoc = snapshot.docs.first;
        debugPrint('First document ID: ${firstDoc.id}');
        debugPrint('First document data: ${firstDoc.data()}');
      }

      final products = snapshot.docs
          .map((doc) {
            debugPrint('Processing document with ID: ${doc.id}');
            debugPrint('Document data: ${doc.data()}');

            try {
              return ProductModel.fromSnapshot(doc);
            } catch (e) {
              debugPrint('Error processing document ${doc.id}: $e');
              return null;
            }
          })
          .where((product) => product != null)
          .cast<ProductModel>()
          .toList();

      // Сортируем на стороне клиента
      products.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      debugPrint('Successfully processed ${products.length} products');
      return products;
    } catch (e, stackTrace) {
      debugPrint('Error getting products: $e');
      debugPrint('Stack trace: $stackTrace');
      throw 'Failed to load products: $e';
    }
  }

  Future<String> uploadImage(File file, String fileName) async {
    try {
      debugPrint('Uploading image: $fileName');
      if (fileName.isEmpty) {
        throw 'File name cannot be empty';
      }
      final ref = _storage.ref("Images/Products").child(fileName);
      await ref.putFile(file);
      final url = await ref.getDownloadURL();
      debugPrint('Image uploaded successfully. URL: $url');
      return url;
    } catch (e) {
      debugPrint('Error uploading image: $e');
      throw 'Failed to upload image';
    }
  }

  Future<void> createProduct(ProductModel product) async {
    const collectionPath = "Products";

    try {
      debugPrint('Attempting to create/update product...');
      debugPrint('Product data: ${product.toJson()}');

      // Создаем новый документ
      final docRef = _db.collection(collectionPath).doc();
      final newId = docRef.id;
      debugPrint('Generated new document ID: $newId');

      // Создаем продукт с ID
      final productWithId = product.copyWith(id: newId);
      final json = productWithId.toJson();
      debugPrint('Final product data: $json');

      // Сохраняем документ
      await docRef.set(json);
      debugPrint('Product created successfully with ID: $newId');

      // Проверяем, что документ создался
      final savedDoc = await docRef.get();
      if (savedDoc.exists) {
        debugPrint('Document verified in database');
        debugPrint('Saved data: ${savedDoc.data()}');
      } else {
        debugPrint('Warning: Document not found after creation');
      }
    } catch (e, stackTrace) {
      debugPrint('Error creating product: $e');
      debugPrint('Stack trace: $stackTrace');
      throw 'Failed to save product: $e';
    }
  }

  Future<ProductModel?> getProduct(String id) async {
    try {
      final doc = await _db.collection("Products").doc(id).get();
      if (doc.exists) {
        return ProductModel.fromSnapshot(doc);
      }
      return null;
    } catch (e) {
      debugPrint('Error getting product: $e');
      throw 'Failed to load product';
    }
  }

  Future<void> migrateProducts() async {
    const collectionPath = "Products";

    try {
      debugPrint('Starting products migration...');

      final snapshot = await _db.collection(collectionPath).get();

      for (var doc in snapshot.docs) {
        final data = doc.data();
        bool needsUpdate = false;
        Map<String, dynamic> updateData = {};

        // Проверяем id
        if (data['id'] == null || data['id'] == '') {
          debugPrint('Product ${doc.id} needs id update');
          updateData['id'] = doc.id;
          needsUpdate = true;
        }

        // Проверяем createdAt
        if (data['createdAt'] == null) {
          debugPrint('Product ${doc.id} needs createdAt update');
          updateData['createdAt'] = DateTime.now().toIso8601String();
          needsUpdate = true;
        }

        // Если нужно обновление, делаем его
        if (needsUpdate) {
          debugPrint('Migrating product ${doc.id} with data: $updateData');
          await _db.collection(collectionPath).doc(doc.id).update(updateData);
          debugPrint('Product ${doc.id} migrated successfully');
        }
      }

      debugPrint('Migration completed successfully');
    } catch (e) {
      debugPrint('Error during migration: $e');
      throw 'Failed to migrate products';
    }
  }

  Future<List<String>> getAllCategories() async {
    try {
      final QuerySnapshot querySnapshot =
          await _db.collection('Categories').get();
      return querySnapshot.docs
          .map((doc) => doc.get('name') as String)
          .toList();
    } catch (e) {
      debugPrint('Error getting categories: $e');
      throw 'Failed to load categories';
    }
  }

  Future<String> getUserName(String userId) async {
    try {
      final doc = await _db.collection("Users").doc(userId).get();
      if (doc.exists) {
        return doc.data()?['username'] ?? 'Unknown User';
      }
      return 'Unknown User';
    } catch (e) {
      debugPrint('Error getting username: $e');
      return 'Unknown User';
    }
  }

  Future<UserModel?> getUser(String userId) async {
    try {
      final doc = await _db.collection("Users").doc(userId).get();
      if (doc.exists) {
        return UserModel.fromSnapshot(doc);
      }
      return null;
    } catch (e) {
      debugPrint('Error getting user: $e');
      return null;
    }
  }
}
