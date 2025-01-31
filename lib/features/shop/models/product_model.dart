import 'package:cloud_firestore/cloud_firestore.dart';

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
  });

  static ProductModel empty() => ProductModel(
      id: '',
      title: '',
      description: '',
      price: 0.00,
      category: '',
      rentalPeriod: '',
      images: [],
      author: '',
      status: '');

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
      "status": status
    };
  }

  factory ProductModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;

      return ProductModel(
          id: document.id,
          title: data['title'],
          description: data['description'],
          price: data['price'],
          category: data['category'],
          rentalPeriod: data['rentalPeriod'],
          images: List<String>.from(data['images']),
          author: data['author'],
          status: data['status']);
    } else {
      return ProductModel.empty();
    }
  }
}
