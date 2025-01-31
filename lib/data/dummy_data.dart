import 'package:gear_share_project/features/shop/models/category_model.dart';

import '../utils/constants/image_strings.dart';

class KDummyData {
  static final List<CategoryModel> categories = [
    CategoryModel(
        id: '1', name: 'Filmy', image: KImages.categoryFilms, isFeatured: true),
    CategoryModel(
        id: '2',
        name: 'Książki',
        image: KImages.categoryBooks,
        isFeatured: true),
    CategoryModel(
        id: '3',
        name: 'Aparaty',
        image: KImages.categoryCamera,
        isFeatured: true),
    CategoryModel(
        id: '4',
        name: 'Turystyczne',
        image: KImages.categoryTourism,
        isFeatured: true),
    CategoryModel(
        id: '5',
        name: 'Walizki',
        image: KImages.categoryLuggage,
        isFeatured: true),
    CategoryModel(
        id: '6',
        name: 'Narzędzia',
        image: KImages.categoryDrill,
        isFeatured: true),
    CategoryModel(
        id: '7',
        name: 'Okazje',
        image: KImages.categoryOccasion,
        isFeatured: true),
    CategoryModel(
        id: '8', name: 'Inne', image: KImages.categoryOther, isFeatured: true),
  ];
}
