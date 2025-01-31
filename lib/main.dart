import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:gear_share_project/app.dart';
import 'package:gear_share_project/data/repositories/authentication/authentication_repository.dart';
import 'package:gear_share_project/firebase_options.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'common/widgets/services/firebase_storage_service.dart';
import 'features/shop/controllers/category_controller.dart';

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
    }
  });
  Get.put(KFirebaseStorageService());

  // FirebaseAuth.instance
  //     .idTokenChanges()
  //     .listen((User? user) {
  //   if (user == null) {
  //     print('User is currently signed out!');
  //   } else {
  //     print('User is signed in!');
  //   }
  // });
// Inicjalizujemy kontroler CategoryController
  final categoryController = Get.put(CategoryController());

  // Upewniamy się, że kategorie zostały przesłane do Firestore, jeśli jeszcze tego nie zrobiono
  await categoryController.uploadDummyCategoriesIfNeeded();
  runApp(const App());
}
