import 'package:flutter/cupertino.dart';
import 'package:gear_share_project/data/repositories/authentication/authentication_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  /*Future<void> emailAndPasswordSignIn() async {

    if (!loginFormKey.currentState!.validate()) {
      return;
    }

    if (rememberMe.value) {
      localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
      localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
    }

      final userCredentials = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());
      debugPrint("userCredentials: $userCredentials");

      AuthenticationRepository.instance.screenRedirect();

  }*/
  void login() async {
    if (!loginFormKey.currentState!.validate()) {
      return;
    }

    if (rememberMe.value) {
      localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
      localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
    }

    final userCredentials = await AuthenticationRepository.instance
        .loginWithEmailAndPassword(email.text.trim(), password.text.trim());
    debugPrint("userCredentials: $userCredentials");

    AuthenticationRepository.instance.screenRedirect();
  }
}
