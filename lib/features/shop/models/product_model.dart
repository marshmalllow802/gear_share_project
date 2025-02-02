import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:gear_share_project/features/shop/controllers/category_controller.dart';
import 'package:gear_share_project/features/shop/models/category_model.dart';
import 'package:gear_share_project/utils/constants/enums.dart';
import 'package:gear_share_project/utils/constants/image_strings.dart';
import 'package:get/get.dart';

class ProductModel {
  final String id;
  String title;
  String description;
  double price;
  String category;
  String rentalPeriod;
  List<String> images;
  String author;
  String status;
  final DateTime createdAt;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.rentalPeriod,
    required this.images,
    required this.author,
    required this.status,
    required this.createdAt,
  });

  RentalPeriod get rentalPeriodEnum {
    return RentalPeriod.values.firstWhere(
      (e) => e.toString() == rentalPeriod,
      orElse: () => RentalPeriod.oneDay,
    );
  }

  static ProductModel empty() => ProductModel(
      id: '',
      title: '',
      description: '',
      price: 0.00,
      category: 'others',
      rentalPeriod: RentalPeriod.oneDay.toString(),
      images: [KImages.productNoImage],
      author: '',
      status: '',
      createdAt: DateTime.now());

  ProductModel copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    String? category,
    String? rentalPeriod,
    List<String>? images,
    String? author,
    String? status,
    DateTime? createdAt,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      category: category ?? this.category,
      rentalPeriod: rentalPeriod ?? this.rentalPeriod,
      images: images ?? this.images,
      author: author ?? this.author,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "price": price,
      "category": category,
      "rentalPeriod": rentalPeriod,
      "images": images,
      "author": author,
      "status": status,
      "createdAt": createdAt.toIso8601String(),
    };
  }

  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    try {
      if (document.data() != null) {
        final data = document.data()!;
        final id = document.id;
        debugPrint('Creating ProductModel from document ID: $id');

        return ProductModel(
          id: id,
          title: data['title'] ?? '',
          description: data['description'] ?? '',
          price: (data['price'] ?? 0.0).toDouble(),
          category: data['category'] ?? 'others',
          rentalPeriod: data['rentalPeriod'] ?? RentalPeriod.oneDay.toString(),
          images: List<String>.from(data['images'] ?? []),
          author: data['author'] ?? '',
          status: data['status'] ?? '',
          createdAt: data['createdAt'] != null
              ? DateTime.parse(data['createdAt'])
              : DateTime.now(),
        );
      }
      debugPrint('Document data is null, returning empty product');
      return ProductModel.empty();
    } catch (e) {
      debugPrint('Error creating ProductModel from snapshot: $e');
      return ProductModel.empty();
    }
  }

  String get categoryName {
    final categoryModel = Get.find<CategoryController>().categories.firstWhere(
          (c) => c.id == category,
          orElse: () => CategoryModel(id: 'others', name: 'Others', image: ''),
        );
    return categoryModel.name;
  }
}
