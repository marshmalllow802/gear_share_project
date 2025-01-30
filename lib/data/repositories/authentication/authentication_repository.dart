import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:gear_share_project/data/repositories/user/user_repository.dart';
import 'package:gear_share_project/features/authentication/screens/login/login.dart';
import 'package:gear_share_project/navigation_menu.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../features/authentication/screens/onboarding/onboarding.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  /// Utrzymanie authenticated danych użytkownika
  User? get authUser => _auth.currentUser;

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  /// Weryfikacja czy logowanie jest pierwsze
  screenRedirect() async {
    final user = _auth.currentUser;

    if (user != null) {
      // if (user.emailVerified) {
      Get.offAll(() => const NavigationMenu());
      //}
      //else {
      //Get.offAll(() => VerifyEmailScreen(email: _auth.currentUser?.email));
      //}
    } else {
      deviceStorage.writeIfNull('isFirstTime', true);

      deviceStorage.read('isFirstTime') != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(const onBoardingScreen());
    }
  }

  /// Logowanie
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    return await _auth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  /// ---- Rejestracja

  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
  }

  /// Usunięcie konta
  Future<void> deleteAccount() async {
    await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
    await _auth.currentUser?.delete();
  }
}
