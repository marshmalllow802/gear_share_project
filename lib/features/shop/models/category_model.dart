

class CategoryModel {
  final String id;
  final String name;
  final String image;
  final bool isActive;
  final bool isFeatured;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    this.isActive = true,
    this.isFeatured = false,
  });

  /// Empty helper constructor
  static CategoryModel empty() => CategoryModel(
      id: '', name: '', image: '', isActive: false, isFeatured: false);

  /// Convert to Json structure
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'isActive': isActive,
      'isFeatured': isFeatured,
    };
  }

  /// Create model from Json
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      isActive: json['isActive'] ?? true,
      isFeatured: json['isFeatured'] ?? false,
    );
  }
}
