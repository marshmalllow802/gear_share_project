import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:gear_share_project/data/repositories/authentication/authentication_repository.dart';
import 'package:gear_share_project/firebase_options.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'common/widgets/services/firebase_storage_service.dart';
import 'features/shop/controllers/category_controller.dart';
import 'features/shop/screens/add_screen/add_screen.dart';
import 'features/shop/screens/category_pages/category_screen.dart';
import 'features/shop/screens/home/home.dart';
import 'features/shop/screens/product/product_detail.dart';
import 'features/shop/screens/profile/profile.dart';
import 'features/shop/services/firebase_service.dart';
import 'utils/constants/routes.dart';

Future<void> main() async {
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  /// -- Inicjalizacja Firebase i Authentication repository
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then(
    (FirebaseApp value) => Get.put(AuthenticationRepository()),
  );
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
      debugPrint('User: ${FirebaseAuth.instance.currentUser?.uid}');
    }
  });
  Get.put(KFirebaseStorageService());
  Get.put(CategoryController());
  Get.put(FirebaseService());

  // Мигрируем категории
  // await Get.find<CategoryController>().migrateCategories();

  // FirebaseAuth.instance
  //     .idTokenChanges()
  //     .listen((User? user) {
  //   if (user == null) {
  //     print('User is currently signed out!');
  //   } else {
  //     print('User is signed in!');
  //   }
  // });

  runApp(GetMaterialApp(
    getPages: [
      GetPage(name: KRoutes.home, page: () => const HomeScreen()),
      GetPage(name: KRoutes.profile, page: () => const ProfileScreen()),
      GetPage(
        name: KRoutes.product,
        page: () => ProductDetail(id: Get.parameters['id']),
      ),
      GetPage(
        name: KRoutes.category,
        page: () => KCategoryScreen(
          category: Get.find<CategoryController>()
              .categories
              .firstWhere((c) => c.id == Get.parameters['id']),
        ),
      ),
      GetPage(name: KRoutes.addProduct, page: () => const AddScreen()),
    ],
  ));
}
